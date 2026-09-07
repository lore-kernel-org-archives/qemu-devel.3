Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F50C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3ZYn-0006E5-Pb; Mon, 07 Sep 2026 09:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x3ZYl-0006CH-PW
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:38:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x3ZYj-0001Cc-56
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788788332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZMsqVPCk9cBPuuqIYeYWgcdYpzxIsf1/5K3YRjJ+gfY=;
 b=NwkyjpTR052HPgvYHpdbkBXGsF9XBjO4ixmucO7gUSkgVhu86/3k9Uz8T88fAgrsAkDCYa
 YhZCjGENBVoQOifRk8zpjipF047oFjYHQ6Wqz2ha7T/LrTZXSr8KnyHfmW7hN5XfxHkVjs
 g3RD99qdYODTZNHyWFVJTw91Gflvp9Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-snVnSEbGNomvl3i20um0DA-1; Mon, 07 Sep 2026 09:38:51 -0400
X-MC-Unique: snVnSEbGNomvl3i20um0DA-1
X-Mimecast-MFC-AGG-ID: snVnSEbGNomvl3i20um0DA_1788788330
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-499b99a8a10so33368045e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 06:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788788330; x=1789393130; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZMsqVPCk9cBPuuqIYeYWgcdYpzxIsf1/5K3YRjJ+gfY=;
 b=aP4/J9Dq/d//6K3+BXMaDWdFmVqBysVhZRbZ1qxAcuZVVxzSWNzug1/5Ak/DvwI3hb
 rARJx4B5088/yJs7oeWbrK5EpTpH4Vhh5fRg7D7gr/iHPZe34o6ZNKAlA6Hie+N9RNO/
 xoQQtgwK+7Yh4DUeqe0sIHChjqxTBgwnb7yzGf7863XHm/HJbMlQ/VHSE6+QbmPgv+IU
 d9uAvWAkSTXb09Hct3uwjmbIyJ4vg4lFuIH80rW5R2GCxhI78TngYJAB3iNOFxgE/UWa
 f+FdI9fGQ1bDb7e9B2+uyzI+TsiMBBobepRBFAOGojF7KbtSZWFsiw0FRjdoMvk73Gn/
 4IbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788788330; x=1789393130;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZMsqVPCk9cBPuuqIYeYWgcdYpzxIsf1/5K3YRjJ+gfY=;
 b=RcoWFXOi4vuz0O0WKc0i2OUpXXJ4G9vIdWr/QSg1+xcrL5cdZ2Iv5BPTNuMCwMtpzT
 /2AKgDf4S9b5cMdC1Kpc4oMmH45Mu3NJ6BaCdWXGUBljHZJeXWqQ8E2Lt5uBNARJuMoA
 zBdCdIBZknUZucWF6HvTVLFbROgg/BneGjeP6MQSYtk78IgqeqvEO5aeL1PLuO0WpaL4
 nttkXPezFINSroi/aKG3VZTfOJ0wctVonHhRLkcCyxPmyXLOtjDjTJDjj/bh5CuP4QTH
 yMK7QQk4yOFB+xpzJ6Iu93bg8BFv85gfoAswSP6+zyT6IdSr3hmTTnMeJVl3cl7iBCUU
 x7rg==
X-Forwarded-Encrypted: i=1;
 AKwUvByaDFif22zQczpu+HNDTszyLU3laUgFNVwnwLkUy4oWdd0d2cHkLaVK8eWtXO7UhFWiDnryptF4chOa@nongnu.org
X-Gm-Message-State: AFuF++kIhLBiLBr71vUc3QWJcYZ+29jFgdcIMuNCQilUn53VwCMqtNhT
 v2aJAcFMrli8iSe/bf1GXr2xLFJDW8nDnCMJWcXYvNg9jWDsRba2l1woXrR7WP3fRx0VY4cFu9+
 AA4LQvwk6sijjfov9ScencdTusGRPq5/ljV9rT8PcDySTUXx6Y1pWw4df
X-Gm-Gg: AYBFou32KsyxtXCF8VQYOJtrCJSMWfLsaAtxOVwtTvuTPDtrQB4H7ObSWpsHRlhNxU4
 ik9Z1pdQZ5xCwKksx9ULmljpNd6hNuC7uAb/XiXcsn86RJz2i9V37HgVcATsGDKfuMyeQa+Xm1w
 aEGKaeI8QIPSLSUcpn5MLiH30elXLqf8LZNhmPlPMGb9hWxW6tr0/FHkYxWtItIrcRyxgvQoL8m
 0yg0ifsw2/Blxg/B7XWcIS5dBZ9nqeDDkPqMxxupTIKmvdd61lFCsbVSWU8O2Twu7Ia8NKXF2p5
 20TFthgfsrbtkbPg8GNoRSM/SsgXxveLCdYZLGHrffDSIyAGMhEDAYcW2XvZmULndpUC55TP
X-Received: by 2002:a05:600c:4455:b0:493:f783:c46a with SMTP id
 5b1f17b1804b1-49d1754fdf6mr11213795e9.6.1788788329993; 
 Mon, 07 Sep 2026 06:38:49 -0700 (PDT)
X-Received: by 2002:a05:600c:4455:b0:493:f783:c46a with SMTP id
 5b1f17b1804b1-49d1754fdf6mr11213295e9.6.1788788329559; 
 Mon, 07 Sep 2026 06:38:49 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.70]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee7febb4sm430252015e9.14.2026.09.07.06.38.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 06:38:48 -0700 (PDT)
Message-ID: <b1ed4b7e-eb84-40a2-a5c7-fc9b9ca65353@redhat.com>
Date: Mon, 7 Sep 2026 15:38:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] tests/functional: replace HMP with QMP
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20260907-nohmp-v3-0-c11e7d0d3d7d@redhat.com>
 <20260907-nohmp-v3-1-c11e7d0d3d7d@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260907-nohmp-v3-1-c11e7d0d3d7d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 07/09/2026 15.13, Marc-André Lureau wrote:
> Replace HMP with QMP equivalent.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   tests/functional/arm/test_integratorcp.py | 13 ++++++++-----
>   tests/functional/m68k/test_nextcube.py    | 11 +++++++----
>   tests/functional/mips64el/test_malta.py   | 13 ++++++++-----
>   3 files changed, 23 insertions(+), 14 deletions(-)
Reviewed-by: Thomas Huth <thuth@redhat.com>


