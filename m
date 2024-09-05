Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9458CE7AA2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 22:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smL9N-00051B-7t; Thu, 05 Sep 2024 18:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1smL9J-00050Y-2f
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 18:40:21 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1smL9G-0003cW-Ok
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 18:40:20 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e1a8ae00f5eso1578501276.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 15:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1725576008; x=1726180808; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vZ3psB38abY9TJoPVqgCD+bqAdGdJEpzJHJBqirRm8Q=;
 b=BwKQR0cWUOjVyxHzcxk4khU9gvwnkNHOzNnrbpXQs2lPH+ux5vahixBFUm+z5NR1Nk
 hkKBq1G2ndA+Stn9gDXfQmUbg6+KRH3AJlU0/awUaZie+1lmrZeqR3Pa6P2aVZLJoaJ9
 utUPjtCN2vTI/mRgK+3lKhXUqwCrgEYG5VMLnaUER2+J3hT27mxMbr7wZ3DonS9ZmE+0
 g0d3F5sUo3B+pNailJpuv5lcONvvYgLmttg6ihDSacuQ9fit2C/NvKAIBFz7FdpFxGCO
 sqkSr09G+nwo74ltU2kSZXm5AVY0zsgCV8B/mxWjT4+GeOzQovZLJBueIa2aH5rW8zf/
 yEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725576008; x=1726180808;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vZ3psB38abY9TJoPVqgCD+bqAdGdJEpzJHJBqirRm8Q=;
 b=hJytJ9sAIbbVhBBfYSiiRzZxTOgH4pUO5z8GumWBnH01wBBdq+KVhax+jSVrYegBc5
 YNPvCJBW5qoWAw0/tODFMhruvChU+6mFSa05fbCpw0coFqSEEqKFnnVndNHuQ8SauICl
 Pkr/NPIGprVAapizhQlhMhTW5QtHvBEiAN5BmEnIvsMNAetMIiW1ERDAO04F0+zzFEcN
 2eWJBYmBuAuonjuJVk+EQ+DH9/tpGONAyBAvmiRlnElr/L5psEnPu/udZlC1a+w3F2bX
 23Bxv3C4X9ZApEvjxvbh5m+8rqayhXNO6/4RJ2gZW1KAW1oIwJQMi1NlMILy4yRuepb0
 S9Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZal7YvNsi/Xoj+g7xAx8w+eZQNP6P6i6hODjyIUIkYmGmtqLY3VROXANMmG0pGkwuDnh8et4ohJxJ@nongnu.org
X-Gm-Message-State: AOJu0Yy7/b2uagWuQYdAiUDRLktjvJW5sezXzGNo9FnWpqp3MnX3zaCu
 YbYaMUj75cbADvZL2igitAGOG83UQiMvBivuKCbmvnPoA/cnxhkKqNY4lvEGEJ0yATyx62FrcHV
 H9sT6/jXbgW/sbuJ8W+s1MfUfni3SETv3khr6+A==
X-Google-Smtp-Source: AGHT+IGZTMRKsyMw3dxinQ1GFaJNvdCsHGfv/yrS9qDj2pNf288mMt7Kv0qxIg5PGBa5+gY7EWnfXnbNeFdGh4g9bwA=
X-Received: by 2002:a05:6902:274a:b0:e1c:fa56:9b72 with SMTP id
 3f1490d57ef6-e1d34a36f9bmr821945276.47.1725576008012; Thu, 05 Sep 2024
 15:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240830232722.58272-1-yichen.wang@bytedance.com>
 <20240830232722.58272-4-yichen.wang@bytedance.com>
 <CAE8KmOx+yYEKXC2-cgBJK=0kb4dxi=Gxoqvm1WY9faBF9A5f3w@mail.gmail.com>
In-Reply-To: <CAE8KmOx+yYEKXC2-cgBJK=0kb4dxi=Gxoqvm1WY9faBF9A5f3w@mail.gmail.com>
From: Yichen Wang <yichen.wang@bytedance.com>
Date: Thu, 5 Sep 2024 15:39:57 -0700
Message-ID: <CAHObMVZm=DDZT2KOZFgrR-ujYE42_DMH-_2X_nmJ6zTa2kLD6g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 3/5] migration: Add migration parameters
 for QATzip
To: Prasad Pandit <ppandit@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, 
 Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>, 
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>, 
 Xiaoning Ding <xiaoning.ding@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=yichen.wang@bytedance.com; helo=mail-yb1-xb29.google.com
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

On Wed, Sep 4, 2024 at 11:11=E2=80=AFPM Prasad Pandit <ppandit@redhat.com> =
wrote:
>
> On Sat, 31 Aug 2024 at 04:58, Yichen Wang <yichen.wang@bytedance.com> wro=
te:
> > +/*
> > + * 1: best speed, ... 9: best compress ratio
> > + * There is some nuance here. Refer to QATzip documentation to underst=
and
> > + * the mapping of QATzip levels to standard deflate levels.
> > + */
> > +#define DEFAULT_MIGRATE_MULTIFD_QATZIP_LEVEL 1
> > +
> ...
> > +# @multifd-qatzip-level: Set the compression level to be used in live
> > +#     migration. The level is an integer between 1 and 9, where 1 mean=
s
> > +#     the best compression speed, and 9 means the best compression
> > +#     ratio which will consume more CPU. Defaults to 1.  (Since 9.2)
> > +#
>
> * Should the default compression level be at the median of 1 - 9 =3D> 5
> or 6 ? A compression method (QATzip) choosing speed (1) over
> compression as default seems contradictory.

This is being discussed on Patch V2,
https://lore.kernel.org/all/20240326224221.3623014-3-bryan.zhang@bytedance.=
com/.
The conclusion of the discussion with Intel is to keep 1 as the
default level.

>
> Otherwise:
> Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
>
> Thank you.
> ---
>   - Prasad
>

