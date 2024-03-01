Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07F6C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 22:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgBhZ-0000SU-Rk; Fri, 01 Mar 2024 17:50:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rgBhY-0000SE-61
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 17:50:00 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rgBhU-0008Iq-Fd
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 17:49:59 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5131316693cso3273661e87.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 14:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1709333392; x=1709938192; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UJ2kxMmawni/vMaCKfd4juzzcGlAUyNFGIeOtH398MU=;
 b=Yk5C4CRwH+N23NywGjKHP+Gh2B/6KwxNiJTdFkbRRlvz0Gzol7BKsc9WeGbBTUOxAP
 R4aQxCp2oc++GkRaVM8lFW+w2fSPdAga9XRHZoiS4vYp+7ABh9lmMsIrg8sTP6JdqydV
 bedodIOJImRKjmOnHLI75pYH/5NyMmf1zAc1QVpJSiwBkyYw8qxroibDj+qIzCYLS8eO
 lnspJIVL2/HY7AS8NI1pfpGGUJNin0dAR7GVEQZMYdGRv9HrJ12dQVa2Rh52nB1Nq9KY
 eUtQw5b+BAKKyy7xK/x0GE/Zkz5VuCugJLN5X8U6WrN5WPWMlg7nQyzb2Zvz/a2Fu+Pq
 XAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709333392; x=1709938192;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UJ2kxMmawni/vMaCKfd4juzzcGlAUyNFGIeOtH398MU=;
 b=HW7mF0etAukZfTuVgyVq4fWQBFnTBWAyE5Z8ywjRS+G3nt0crN482Wn7+BpssR+iDB
 LvuWJEILyM8UOnQe77k+5xXcam3eNJezO3r8KYI4yhbwGN++j1fJ44eUJ6TGhcQO9rYn
 llpcVphQ3aH6H2gK0PfCd47/iOTQG0RWZORWjgq1MHvrfPOgleJVFJ8H5tVd55bUQvfh
 qlfcHq2fZ7koTVjGUI5pbmWHY2aZcRfEeFmpOBuh/84X+5jVFHZ7CKR1aIMDeHqVsm6Q
 br2khWGi93TIQpZiYjbGakxnBTJPBEiFougy1fPAZXgXA3rto4ZSWPgWKy/FlEbwdeTE
 TjCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOpJ1vYxgDYDQt9+JWxe+tosw1uGMnSf9QF9/5Gp13pxUfnskETJ/AYYhjMOkv79EABHWTbWgARz0zh3xPWi2rG5vKg2I=
X-Gm-Message-State: AOJu0YyTBNr/o5F38KPtiT82M5tg8E8HlYMpTlemSYVzEMzVK+Hwo0/1
 px2Ahh2ZdWbk5VkyhJOO3lKaRhl8WcZf8+ErNwVHiFFYrBUK6At8veudzYkuzoM7HxQeW3M8OXD
 h3f4xu6trp+woTFHn7WriQlojpW+VltRKtP9m1g==
X-Google-Smtp-Source: AGHT+IHoHKjwKdzCheqYxmV4ZZgwvEamP/Fy0lX+T9Satk1T6pIB2ARqBPRhUS5OQ3QZrWrEpUwaOKwrZD67u+1hiSk=
X-Received: by 2002:a05:6512:44a:b0:513:2b10:cc28 with SMTP id
 y10-20020a056512044a00b005132b10cc28mr2342158lfk.9.1709333392434; Fri, 01 Mar
 2024 14:49:52 -0800 (PST)
MIME-Version: 1.0
References: <20240301022829.3390548-1-hao.xiang@bytedance.com>
 <20240301022829.3390548-3-hao.xiang@bytedance.com>
 <871q8uqule.fsf@pond.sub.org>
In-Reply-To: <871q8uqule.fsf@pond.sub.org>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Fri, 1 Mar 2024 14:49:40 -0800
Message-ID: <CAAYibXhbeC3GJVghkgnzrFCJT1veNs1UkGJ4Sxih_ALqV9LQog@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 2/7] migration/multifd: Implement zero
 page transmission on the multifd thread.
To: Markus Armbruster <armbru@redhat.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, thuth@redhat.com, 
 lvivier@redhat.com, jdenemar@redhat.com, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=hao.xiang@bytedance.com; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 29, 2024 at 11:28=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> > 1. Add zero_pages field in MultiFDPacket_t.
> > 2. Implements the zero page detection and handling on the multifd
> > threads for non-compression, zlib and zstd compression backends.
> > 3. Added a new value 'multifd' in ZeroPageDetection enumeration.
> > 4. Handle migration QEMU9.0 -> QEMU8.2 compatibility.
> > 5. Adds zero page counters and updates multifd send/receive tracing
> > format to track the newly added counters.
> >
> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
>
> [...]
>
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 8da05dba47..846d0411d5 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -671,10 +671,15 @@
> >  #
> >  # @legacy: Perform zero page checking in main migration thread.
> >  #
> > +# @multifd: Perform zero page checking in multifd sender thread.
> > +#     This option only takes effect if migration capability multifd
> > +#     is set.  Otherwise, it will have the same effect as legacy.
>
> Suggest
>
>    # @multifd: Perform zero page checking in multifd sender thread if
>    #     multifd migration is enabled, else in the main migration
>    #     thread as for @legacy.
>
> Thoughts?

Sounds good. Will change that.

>
> > +#
> >  # Since: 9.0
> > +#
> >  ##
> >  { 'enum': 'ZeroPageDetection',
> > -  'data': [ 'none', 'legacy' ] }
> > +  'data': [ 'none', 'legacy', 'multifd' ] }
> >
> >  ##
> >  # @BitmapMigrationBitmapAliasTransform:
>
> QAPI schema
> Acked-by: Markus Armbruster <armbru@redhat.com>
>

