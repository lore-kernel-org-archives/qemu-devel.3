Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9875FF53D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 17:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2BkA-0004xx-Un; Mon, 16 Mar 2026 13:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w2Bk7-0004vx-Q5
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 13:28:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w2Bk5-0003zf-Pz
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 13:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773682116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Leq06PUdI16r8lHD6HgtmosRlvNObtj1nIAw7jOBWw=;
 b=RySc0BzygCu9liAC0ZsIumUJWlyHspqTjZwTQve7nr3fUMhg01wpw6HZuvVBJfV/WWS9Ep
 BpaZ65D4MMWcM8O1Xw9PoRJ6UhuarqVsOZAbkYP64CmcCzPuijz992N7O+y8jH0i3Ok00N
 zF5CE7wwlW5s36YbJPF7Cnfr4E5/uNk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-3XEQ4Qn0NcKh54A-WbouEA-1; Mon, 16 Mar 2026 13:28:35 -0400
X-MC-Unique: 3XEQ4Qn0NcKh54A-WbouEA-1
X-Mimecast-MFC-AGG-ID: 3XEQ4Qn0NcKh54A-WbouEA_1773682114
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4853a9467c5so27756975e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 10:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773682113; x=1774286913; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2Leq06PUdI16r8lHD6HgtmosRlvNObtj1nIAw7jOBWw=;
 b=I8AiQSnYKk+0hREmU7FeG9AXAVBycpLorxMcE7uTL7Jb+yOY7oEJCQSyDEhJR8AsY9
 rFODfLdUe8mInsizZ7zfXi6PbAWKgKNpLYbsHBr/JgwU4lPZ3klvwizx6w00s+wBB8U3
 VEAHSiWgsS58zUOWUw+G2/nhujYm1E/pxGnqHvtYE3Fbm8dPQJwHZka44GxsEmhglTFa
 NB7HlrdfMK8t6v3A8X1TvNlR0fH8EjirdgnlH7G7GxndMKlhsWdY/8ogymEzQcvnWYdv
 7HgLeWFCJ5vB81yCZUPNGnYdSzUROW6wjii+97xcSPG1WgUfSrOigaP4qhQTSu6DUrrw
 DVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773682113; x=1774286913;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2Leq06PUdI16r8lHD6HgtmosRlvNObtj1nIAw7jOBWw=;
 b=hkNquwP+pqQVeK4m4R4jLd2FL5xEV7HQ1rHYuBD+5/GN8als8uENTzC6+P288ElV7G
 j2m9wUnaGek6ORSMAZBYS3fnnw3KHSun1UURLZaGbq71dGpCgMl5jJVddGwOWMw4PN2n
 Rs89Jqgyq083yXpJ7sUH8WUHuZGrvkaZGpj2vgJPShpOF3sIfj/VIA3HbhJGLV6MKFt3
 WR0funHi85naECXauDTHT8R6OLhYjRAZUtkojGZ81fKgM1PoOPCk+7nqq3ctq5Bs8+J2
 t53lSYtNgqUW0m3ymo08VmBB/0QKmgLTUq2Ri/T10qQLkoroSlo8HQ/HGxpJioVdKP9w
 SzMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyDWrcIGxIVmP2CahUIKgbxeHk8TfW6Jz2mmsQ1ix6F/Kzlr04TsI4eCtL2Lw0U+whdAlsgcctEzNo@nongnu.org
X-Gm-Message-State: AOJu0Yxkb24yB4jXybUbnS78e8wPdk1FolQ80SXcXMr/AhWO0AKAotbv
 Xt2grXQmQWhJMbL8apwFl2cRgTTrpDSdk2NF533+J5T73w+2CKQRg2WPDbNpq3pHblQbgxC6G9B
 8KDkR1UCyiKUvXgzd50P9IC8gZgcs856LUgHlRhjq1Y6r3d8SHLvKnl/+pxwLigGY
X-Gm-Gg: ATEYQzw96JWfHy4I1SPOauL8q7RfJZadzpiwuExFNGf4HegIJli93t/DZrep+IFQBY3
 qLHIzjTKniUaqcvQJaQPm1g1wTJyimGa0mTfptqQAe+gTkW7oczoS8NjQ22dirKK/hFVVvLABaI
 S2sHGPbKnmd7lFzN7CytfoFRhM7/ykQ4gurHw3QwrwmPubSmdke32Pjht5GY/LGBpaEc4anJ8Xw
 tYoA34/GBonRWbTQmGjNpmPdjRiWaQBYitN4svbWdoCJKN/2bqqou6dwp1HwbsvwYvaz1oD8Hjy
 KQBU+lDmNApSci1RIJGuYrWPNVgm6JjREfiWiGWYPOUHhex0ukIOUiNiA/tuoeTWgLHFxwCL/6v
 5N9f2DUdGpYofjbrdn+IhlZbkPb5aDyipoaSo/fvGuog5Kujo289Jcl0e1h4QG7m8VUnZFLchOB
 CY2fsUPC4i2rrLsq/zPupDUxsOXkHBi87C6BqC7GQi4RKv5Toogbw=
X-Received: by 2002:a05:600c:8b75:b0:485:3fe6:21f5 with SMTP id
 5b1f17b1804b1-485566d2ffdmr233063725e9.10.1773682113304; 
 Mon, 16 Mar 2026 10:28:33 -0700 (PDT)
X-Received: by 2002:a05:600c:8b75:b0:485:3fe6:21f5 with SMTP id
 5b1f17b1804b1-485566d2ffdmr233063245e9.10.1773682112837; 
 Mon, 16 Mar 2026 10:28:32 -0700 (PDT)
Received: from ?IPV6:2003:cf:d737:d02c:3210:ed4b:e671:ceb9?
 (p200300cfd737d02c3210ed4be671ceb9.dip0.t-ipconnect.de.
 [2003:cf:d737:d02c:3210:ed4b:e671:ceb9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485563953dbsm179665205e9.0.2026.03.16.10.28.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 10:28:32 -0700 (PDT)
Message-ID: <ad6a2467-3763-4590-8a86-097ab916a4c1@redhat.com>
Date: Mon, 16 Mar 2026 18:28:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iotests/041: add test for mirror with throttled NBD
 export as target
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, qemu-stable@nongnu.org
References: <20260311145717.668492-1-f.ebner@proxmox.com>
 <20260311145717.668492-3-f.ebner@proxmox.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260311145717.668492-3-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11.03.26 15:54, Fiona Ebner wrote:
> Mostly in preparation for commit "iotests/041: add test for duplicate
> job-complete with throttled target".
>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>   tests/qemu-iotests/041     | 112 ++++++++++++++++++++++++++++++++++++-
>   tests/qemu-iotests/041.out |   4 +-
>   2 files changed, 113 insertions(+), 3 deletions(-)
>
> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
> index 8452845f44..a7e1980f13 100755
> --- a/tests/qemu-iotests/041
> +++ b/tests/qemu-iotests/041

[...]


> +    def tearDown(self):
> +        os.remove(test_img)
> +        os.remove(target_img)
> +        os.remove(backing_img)
> +        os.remove(target_backing_img)

It would be good if tearDown() could still contain the VM/QSD shutdown/stop.

> +
> +    def test_throttled(self):
> +        self.vm.cmd('blockdev-mirror',
> +                    job_id='mirror',
> +                    device='source',
> +                    target='target',
> +                    sync='full')
> +
> +        time.sleep(1)
> +        result = self.vm.qmp('query-block-jobs')
> +        self.assert_qmp(result, 'return[0]/ready', False)
> +        self.vm.qtest(f'clock_step {4 * 1000 * 1000 * 1000}')
> +        time.sleep(1) # in real time, the rest should now comlpete fast

I think the clock_step belongs on the export side, the QSD.  On the 
other hand, QSD has no way to enable qtest, I believe, so it won’t work 
well as an export here.  I think it works accidentally because throttle 
allows a burst, and can allow to write 3 MB in 2 seconds.

This whole test is also a bit fiddly. It needs to write 3 MB in one 
second, I believe, which seems prone to being flakey.  I’d be happy with 
a null export on the target side, if that still did the job (pun intended).

(Also *complete)

Hanna

> +        result = self.vm.qmp('query-block-jobs')
> +        self.assert_qmp(result, 'return[0]/ready', True)
> +
> +        self.complete_and_wait('mirror')
> +        self.vm.shutdown()
> +        self.qsd.stop()
> +        self.assertTrue(iotests.compare_images(test_img, target_img),
> +                        'target image does not match source after mirroring')
> +
>   
>   if __name__ == '__main__':
>       iotests.main(supported_fmts=['qcow2', 'qed'],
> diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
> index 46651953e8..5273ce86c3 100644
> --- a/tests/qemu-iotests/041.out
> +++ b/tests/qemu-iotests/041.out
> @@ -1,5 +1,5 @@
> -...........................................................................................................
> +............................................................................................................
>   ----------------------------------------------------------------------
> -Ran 107 tests
> +Ran 108 tests
>   
>   OK


