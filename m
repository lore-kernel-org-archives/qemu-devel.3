Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C25D2E02E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 07:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRQeq-0005lM-7i; Fri, 05 Dec 2025 02:55:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vRQee-0005bf-Lu
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 02:55:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vRQec-000735-KJ
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 02:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764921294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3NBRUXrLWWNtd1e3IsvYAloptvVEGDZJLwxJTVKNTPI=;
 b=fBkP+UAS65V+n3YYfr62MtGl2Zo6eHbLvuKBvnmq4ohBIHfy9Cjaz0DyBL7weoZayrtLZT
 RUhc4mm4s92N61eECnwIXFIMcTK4K+nT0mqSnClRWrLRomJVdOwctb0+QeaCbIUi4+/KtH
 Unn1lxUTAOev1AOfmHa0TTGXTp4I4o0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-hTDpxcooNfKJOzZ3Mr8xug-1; Fri, 05 Dec 2025 02:54:53 -0500
X-MC-Unique: hTDpxcooNfKJOzZ3Mr8xug-1
X-Mimecast-MFC-AGG-ID: hTDpxcooNfKJOzZ3Mr8xug_1764921292
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47799717212so10722295e9.3
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 23:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764921292; x=1765526092; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=3NBRUXrLWWNtd1e3IsvYAloptvVEGDZJLwxJTVKNTPI=;
 b=NtQ7zojmS9PNQO3t8OpPne3fV4CZNU9MPmEusIGXPipXVNZFR7fNNzNcYfFsuZoWCk
 X0C7Vnu1wR0672vKpqfW/JPWMMenM6sMfYByXVQ1rACRJaca/moFxu2+rSmCyDFUMyg/
 oz+MakYyMijVnLr4xvng8guJVEcqx5HY+Dz4+I31QRDEx1bR4Ef9GBn2row4KwdGZkJu
 kQHRt+pVsOqoOBd6tYg1R+iwGC03/cUubpkg+aln/eK/exVlgEFiaEcRN2YGrtXGN/1e
 qPgPntddBWdq1KGdGcDs5fHgQbG2igzh6tT/m6qAQ7s0d93VpN+HN9vIzfdYNEUcKhIH
 Ey5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764921292; x=1765526092;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3NBRUXrLWWNtd1e3IsvYAloptvVEGDZJLwxJTVKNTPI=;
 b=ImdexIM81Bnz/8mCFmgvqtJ4uucVC1CX/NssL9gE9vfsKqqKkLQls0TJiGI8vgD/bT
 ixHdv0RSIvzncvycE9GlRDM6k6nEEdpBnH8n494B05dTFbfWsZJ3eOqkzXnSz5t16Wpl
 HbZxrg3umgWlicIU6/ph9RH9GME0V4sSpGd5IX1u6/unk6Mbkd/wna0u7dGqsi8f/snt
 /Ug3Ydv7qdWkVGyLLcGnzPYe6pyWsnQ3wlOFdjNBBJoriyUyg1q27NLf6UJkDoKwYdkm
 th2/MZaj4pDgD9dZhtYv33FpGlkLtG3aRuRC+yCYIWGsj0s2lwa81GiZy1j7od7loYe8
 sJbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWg76NHflflCJ7DoouQxI8g2h8HA/wd64p8nyvTFuSpt+Hbg+RxnSJJO01pkELzQ8pIY7pdzNLKZrg@nongnu.org
X-Gm-Message-State: AOJu0Yyz7SWkHJX8sujp5FRN5RsHqIlSrmgS0s+ZZhBbk8t7PHz/1pD+
 UrCf/mApmD96QrgZPN465rj9bTUY7bqFXTfD8/iRAqnXGyZTuCXQZ0NB7j1UfjiWxJMD2KVSysq
 VeOgQwE4PEMuwX+DfivUd2NVC1Uk35ezGt/PEjtfPqQFREeaKXvMuvPQh
X-Gm-Gg: ASbGncsh0jtxvZlQv7Aq7LJ+FgZYqFxDHm5e50woc8MfgEuttBU7Zk4EnqX8m/IoHug
 fHvFTqhJsdAvqNxQkr7ZRDMl2j/p+i7BkM86iN6OAFYMCvs/yV242dnFanWPoTiTHaSeD5JDeCJ
 l+BGH5UoyNkHlXKC0D2pV6DKWYGiRg0XVNiI9Rj7jv4Ve7o/FjkXUr7X8K3mr/W3wqmYLwwS/HI
 FthX1caRu80oxcrIG9CbxTAKmr2lIgFjWG2kAt4iizzVSWDJWZ+z9tNA3hC3u3BUIFz7SQl0oiW
 1in7ttg/P9MQdJCioF0SZWodAHaIBWaB3EQbMRRv+h/NJgqm0eaxq86vtIox3XyY3TKuMhfC2wQ
 JyIFySMY=
X-Received: by 2002:a05:6000:184a:b0:42b:4185:e590 with SMTP id
 ffacd0b85a97d-42f731d18f4mr9678763f8f.58.1764921291850; 
 Thu, 04 Dec 2025 23:54:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRqo3xBSWceXq3UqJZerc1wupDYKBMiINEwC4wCdQrqWlZpSTyhehNnesjpbZrg7AAOkqNqw==
X-Received: by 2002:a05:6000:184a:b0:42b:4185:e590 with SMTP id
 ffacd0b85a97d-42f731d18f4mr9678735f8f.58.1764921291406; 
 Thu, 04 Dec 2025 23:54:51 -0800 (PST)
Received: from [192.168.0.5] ([47.64.112.197])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d222478sm7295497f8f.20.2025.12.04.23.54.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 23:54:51 -0800 (PST)
Message-ID: <50eab2a6-fa1e-4639-b865-785ff1949fe5@redhat.com>
Date: Fri, 5 Dec 2025 08:54:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] gitlab: drop explicit pxe-test from the
 build-tci job
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20251204194902.1340008-1-alex.bennee@linaro.org>
 <20251204194902.1340008-3-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251204194902.1340008-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 04/12/2025 20.48, Alex Bennée wrote:
> This needs libslirp to run and as debian-all-test-cross will soon be
> based on qemu-minimal we won't have it in a few commits.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/buildtest.yml | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index 44df116139b..dfe954fe3ce 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -656,14 +656,12 @@ build-tci:
>           --target-list="$(for tg in $TARGETS; do echo -n ${tg}'-softmmu '; done)"
>           || { cat config.log meson-logs/meson-log.txt && exit 1; }
>       - make -j"$JOBS"
> -    - make tests/qtest/boot-serial-test tests/qtest/cdrom-test tests/qtest/pxe-test
> +    - make tests/qtest/boot-serial-test tests/qtest/cdrom-test
>       - for tg in $TARGETS ; do
>           export QTEST_QEMU_BINARY="./qemu-system-${tg}" ;
>           ./tests/qtest/boot-serial-test || exit 1 ;
>           ./tests/qtest/cdrom-test || exit 1 ;
>         done
> -    - QTEST_QEMU_BINARY="./qemu-system-x86_64" ./tests/qtest/pxe-test
> -    - QTEST_QEMU_BINARY="./qemu-system-s390x" ./tests/qtest/pxe-test -m slow
>       - make check-tcg

Reviewed-by: Thomas Huth <thuth@redhat.com>


