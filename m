Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D87C54798
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 01:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfrgw-00046b-M2; Thu, 29 Feb 2024 20:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rfrgv-00046T-7e
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 20:28:01 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rfrgs-0001oL-Q9
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 20:28:01 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56657bcd555so2223175a12.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 17:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1709256476; x=1709861276; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hO7saLYeafeg5Dofm8sPNK9jyx6Fp7eFukqro2mtYaQ=;
 b=WSnjwGrO9guE4Rz/RwKXC6uTe3dnrYjs487K5idGjwWp8iiaKo1Uh7w20cC4CcCXbQ
 5kKsdTOaimAP9FwHLp/Yw+T1XFNRK/Pc8YBcmIgOW3D5VesNKLm8NLcNnzBkDBspQzoh
 IT2HK/Rt64OfJ6jbVUBII73czpl1pVmVn2L9JxPJLWl6/TfNJFX2ZRw9+Wm67zR7LFR7
 JCc+tMs4tsVwKJVlLsrHYoqpmKsiE+bCAhpxuahENuED+eZYjJcwPvDhuKRIXdizgXm2
 YrpPk99ufwUwdaGvLlEXyrzaEKJfBKBoDo98FwLdZgGziEZ8XA1RPlDOv+mV3FgpqndZ
 bMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709256476; x=1709861276;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hO7saLYeafeg5Dofm8sPNK9jyx6Fp7eFukqro2mtYaQ=;
 b=XXMCtAdxAUrJmyzQDJ/qbiHUqZdCzJEbwwHXO778SH221/Eb8Mb9uxXUqIZmFkVXaM
 /89YuJe3ke4Nyy5cCY3Nhb7f8FORvtoM+a7X9EaR+3PwQWP9JFnafNBdeQ/9D7KNw1ZP
 Rm6XZhgAWWnmvsJUA5Uczty6UB3xMz3FXFb8/J9+8sfKtcKQSm1gSUd13jrokrrI3h0T
 heJ8h3hadlmLJYQg+nM/O1ZGlhq6LGo7VLU/dadCB+YLo0X7dwKx6KS8YEJ+/UrfEdNb
 YymKY2I3eDnJLPoqaIHJBfC2BYZI4rDRxiaOJUQPbnb2SHTv5tXlpFEt4a/2t1F6lDBM
 BfAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpJkxEDM8sMra8vTmfT1R7UVVOwvRPr/fpSz0hHFL+MeY3PELbSEvVrTtHmOrvoFyZ+POnDwHT09whoWhD+woSsyBnRQ8=
X-Gm-Message-State: AOJu0YxmNop/z9FyBOZ+vsPDZAByZHbRYOAVb3pmLm1+mxtn22QqAl24
 5ZNjproVPyX+4I3mjeKhbgpkEvTC6FUhLI5P9HzNTrznLs+13gmah5NmL4IPtnw/t5nnQpfbqFO
 Tt4ydkGEUzIPJEaja8HLjqow+ErbnUYBbl2dGdA==
X-Google-Smtp-Source: AGHT+IGiRr39q65Oq9IgjEH+gPFosz2kOb+h1zjJLzHef8BdCyW5XXdEEv4y5PumcXhRehTemx5uMTwhiy6gybdkc/g=
X-Received: by 2002:a50:cac7:0:b0:566:d25e:b73c with SMTP id
 f7-20020a50cac7000000b00566d25eb73cmr125598edi.35.1709256475854; Thu, 29 Feb
 2024 17:27:55 -0800 (PST)
MIME-Version: 1.0
References: <20240226195654.934709-1-hao.xiang@bytedance.com>
 <20240226195654.934709-3-hao.xiang@bytedance.com>
 <871q8w29zx.fsf@pond.sub.org>
 <CAAYibXgdaH_=JxswvKaz9qaXRFuRncmkrrSpkqSMbFu=3ypfLQ@mail.gmail.com>
 <87a5nju8ro.fsf@pond.sub.org> <87h6hrz315.fsf@suse.de>
In-Reply-To: <87h6hrz315.fsf@suse.de>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Thu, 29 Feb 2024 17:27:44 -0800
Message-ID: <CAAYibXiy3hQJaeb6urnZBQMa4M=gyxk6m3SPWjH29NB0P10aXg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 2/7] migration/multifd: Implement zero
 page transmission on the multifd thread.
To: Fabiano Rosas <farosas@suse.de>
Cc: Markus Armbruster <armbru@redhat.com>, pbonzini@redhat.com,
 berrange@redhat.com, 
 eduardo@habkost.net, peterx@redhat.com, eblake@redhat.com, thuth@redhat.com, 
 lvivier@redhat.com, jdenemar@redhat.com, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ed1-x535.google.com
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

On Thu, Feb 29, 2024 at 7:47=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Markus Armbruster <armbru@redhat.com> writes:
>
> > Hao Xiang <hao.xiang@bytedance.com> writes:
> >
> >> On Wed, Feb 28, 2024 at 1:50=E2=80=AFAM Markus Armbruster <armbru@redh=
at.com> wrote:
> >>>
> >>> Hao Xiang <hao.xiang@bytedance.com> writes:
> >>>
> >>> > 1. Add zero_pages field in MultiFDPacket_t.
> >>> > 2. Implements the zero page detection and handling on the multifd
> >>> > threads for non-compression, zlib and zstd compression backends.
> >>> > 3. Added a new value 'multifd' in ZeroPageDetection enumeration.
> >>> > 4. Handle migration QEMU9.0 -> QEMU8.2 compatibility.
> >>> > 5. Adds zero page counters and updates multifd send/receive tracing
> >>> > format to track the newly added counters.
> >>> >
> >>> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> >>>
> >>> [...]
> >>>
> >>> > diff --git a/qapi/migration.json b/qapi/migration.json
> >>> > index 1e66272f8f..5a1bb8ad62 100644
> >>> > --- a/qapi/migration.json
> >>> > +++ b/qapi/migration.json
> >>> > @@ -660,10 +660,13 @@
> >>> >  #
> >>> >  # @legacy: Perform zero page checking from main migration thread.
> >>> >  #
> >>> > +# @multifd: Perform zero page checking from multifd sender thread.
> >>> > +#
> >>> >  # Since: 9.0
> >>> > +#
> >>> >  ##
> >>> >  { 'enum': 'ZeroPageDetection',
> >>> > -  'data': [ 'none', 'legacy' ] }
> >>> > +  'data': [ 'none', 'legacy', 'multifd' ] }
> >>> >
> >>> >  ##
> >>> >  # @BitmapMigrationBitmapAliasTransform:
> >>>
> >>> What happens when you set "zero-page-detection": "multifd" *without*
> >>> enabling multifd migration?
> >>
> >> Very good question! Right now the behavior is that if "multifd
> >> migration" is not enabled, it goes through the legacy code path and
> >> the "multifd zero page" option is ignored. The legacy path has its own
> >> zero page checking and will run the same way as before. This is for
> >> backward compatibility.
> >
> > We need one of two improvements then:
> >
> > 1. Make "zero-page-detection" reject value "multifd" when multifd
> >    migration is not enabled.  Document this: "Requires migration
> >    capability @multifd" or similar.
> >
> > 2. Document that "multifd" means multifd only when multifd is enabled,
> >    else same as "legacy".
> >
> > I prefer 1., because it's easier to document.  But migration maintainer=
s
> > may have their own preference.  Peter, Fabiano?
>
> I think we need to go with 2 for consistency with the other multifd_*
> parameters. I don't see any validation at options.c.

Yeah, it's hard to do 1. Someone can also set multifd and then disable
multifd migration. This is an existing problem. I will update the
document for "multifd".

