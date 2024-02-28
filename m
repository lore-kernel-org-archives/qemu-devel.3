Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76EEC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 18:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfOnF-0001rA-58; Wed, 28 Feb 2024 13:36:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rfOnE-0001qz-4F
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 13:36:36 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rfOnB-0002jC-Qo
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 13:36:35 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so197253a12.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 10:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1709145390; x=1709750190; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R+VoYO7aWK51+6HarDNv2G92hElLZ47gJLXgoInfemY=;
 b=CzG5R/9a6g9gPl3ptTKKtNpXuVk5JLhBp+ewlUN8ztRxgnWN5FqeokEPGuyu0iF3UY
 eRmtw3QTKVog5jxLZZQDOyfLw6E32ufA0exidBZpGJ/rBgjMSa9EYIj4lA30mVkn2Et1
 AywvkyNRjc+KOkpxYRQUSVU37Ju3digBXhjZDsNJidZXPDE4h+QuEyNqPvRcdqoAFSGB
 3d2yfpHaKkvuFsCooD741+6spJbV+aTSL92m5bKWB75/KuWxcQBsGE+mJVLDZvO369Zv
 jBLBvJr1QV/Xuo2ANSLF6tPkwkXKsQ6Z35H0EuwsWBOKHY1A4/swwoRi8zhtV9KOKuua
 B4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709145390; x=1709750190;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R+VoYO7aWK51+6HarDNv2G92hElLZ47gJLXgoInfemY=;
 b=ej8vVwbUAgxijNjh8zFTo71nx+UcHA1jqdgaquODFYUerSkGHY6neE9CyBTSSi0Vhf
 Lcnpq8YHMxZnmfaFl664SnygoUBQrldFBniNDYQXa56OFf93mijldj5dM76fLeTARVRc
 SKIgmMiARr50nEO0RvuhhocZrJB/BnHJwXqyuNecRJqjDyvTRwB6yMPl4ZfyN8EtKxoT
 ir0M5v3iOnwGYE7lO4HXFVicaedCpyaBI6torXWiTYTXwdndHl4xZblncgujO1o/KN50
 OoWrpoOnqGgi7Ih2iTcHWCK2KJ4yIEFyanJM5oP43ikhcGm9WAkFre4nJoys8DNIjAMz
 sEdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/MuQc82ptmdmLbwlwIv25KvhDRR/slEcDEfAIiEBODS4lBk9cH6edSXSqdPicpInx7iwcFDObryH7Ws/CC7kEkQEYWpw=
X-Gm-Message-State: AOJu0YyLVU1hTqzOSplBYk1Q2OQNKlXvUqGo3vO4YHrxgYWiEkxh2gIF
 agCG5pqFDIq7gi2mlbYy9DUPBr8B+SbmgFwO0hVA0+rVyqpx5WuY1Gqk4vkJ046c7jKGCSCmAqi
 4yAGSB18t5VjJsiIeoxVNgnhqBz4S8p4w5vkpfg==
X-Google-Smtp-Source: AGHT+IFNDH/baItZSZvkuDlR0kZJv3QgX5bozVnh1bdVClameVxkXji3x9ggrtL0ur6sud9M7+rvS55qCxyUVFO/c0I=
X-Received: by 2002:a05:6402:1619:b0:565:ec92:bec8 with SMTP id
 f25-20020a056402161900b00565ec92bec8mr179207edv.7.1709145390041; Wed, 28 Feb
 2024 10:36:30 -0800 (PST)
MIME-Version: 1.0
References: <20240226195654.934709-1-hao.xiang@bytedance.com>
 <20240226195654.934709-7-hao.xiang@bytedance.com>
 <87wmqozzjn.fsf@pond.sub.org>
In-Reply-To: <87wmqozzjn.fsf@pond.sub.org>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Wed, 28 Feb 2024 10:36:19 -0800
Message-ID: <CAAYibXicsMkZ+QaFtjgSbjk_eL3waOp1fiJQ7M9b5SRXCRa+ig@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 6/7] migration/multifd: Add zero pages
 and zero bytes counter to migration status interface.
To: Markus Armbruster <armbru@redhat.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, thuth@redhat.com, 
 lvivier@redhat.com, jdenemar@redhat.com, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ed1-x531.google.com
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

On Wed, Feb 28, 2024 at 1:52=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> > This change extends the MigrationStatus interface to track zero pages
> > and zero bytes counter.
> >
> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
>
> [...]
>
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index a0a85a0312..171734c07e 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -63,6 +63,10 @@
> >  #     between 0 and @dirty-sync-count * @multifd-channels.  (since
> >  #     7.1)
> >  #
> > +# @zero-pages: number of zero pages (since 9.0)
> > +#
> > +# @zero-bytes: number of zero bytes sent (since 9.0)
> > +#
>
> Awfully terse.  How are these two related?

Sorry I forgot to address the same feedback from the last version.
zero-pages are the number of pages being detected as all "zero" and
hence the payload isn't sent over the network. zero-bytes is basically
zero-pages * page_size. It's the number of bytes migrated (but not
actually sent through the network) because they are all "zero". These
two are related to the existing interface below. normal and
normal-bytes are the same representation of pages who are not all
"zero" and are actually sent through the network.

# @normal: number of normal pages (since 1.2)
#
# @normal-bytes: number of normal bytes sent (since 1.2)

>
> >  # Features:
> >  #
> >  # @deprecated: Member @skipped is always zero since 1.5.3
>
> [...]
>

