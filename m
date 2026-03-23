Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5941DF483C8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ibD-0004OY-SV; Mon, 23 Mar 2026 12:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w4ib5-0004MH-5z
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w4ib3-0001Do-PD
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774285064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tfa54HH+XPXxZEqMtM5d9bOMy+a03QuaBuvSBlziR2U=;
 b=bLGnr55IWfh9S/bSApR86WXDT7CAA+dZJpZs1XkNt9I7+YdL1D61qnwk7+RCFv71+Y/rut
 6VSaMvBmVNP15UB7UmJGRpqNqaKjjqNnWdv596sjYh78Zqup/4csFma19mH3cUsnOwcpa1
 2BwNaptpSaWTxoXZF0wmZ/ckfQukTFI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-uRqMVck7NVanmtUIe796pA-1; Mon, 23 Mar 2026 12:57:43 -0400
X-MC-Unique: uRqMVck7NVanmtUIe796pA-1
X-Mimecast-MFC-AGG-ID: uRqMVck7NVanmtUIe796pA_1774285062
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43b41d45be4so4008940f8f.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774285062; x=1774889862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tfa54HH+XPXxZEqMtM5d9bOMy+a03QuaBuvSBlziR2U=;
 b=Njxpbg5APsLOhCkyX5i/4TUWzXsxYl0sXh9otnJSsNbsKbM22yl9UaD6QDbq03vzRR
 jjfzSipEMOLk9jko9KU2p7fnisTLi05ANorYSi7M04uZQEDOf1HwCklwC2jm6y/uzh6i
 YjshYIX9xoBhvK/eFYWQIuXtXWsbqyxHOJ24SvM+NIAFK7LYa260lJK/fZiZUVUlK2Xa
 BKsXwVcaPyB2ohVwOFLQACJ3kSgxMcGFiElmikTtqR2iAtrM3/nnisP85vsTaiOmlUAr
 lc0rnsO1xlD1jTwOeIIKlAyRK69aboatI5uYnekUjKaj8MeDSxH+bRmvH0FZ3Ykux8rt
 cTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774285062; x=1774889862;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tfa54HH+XPXxZEqMtM5d9bOMy+a03QuaBuvSBlziR2U=;
 b=PWhBiStgptG6LJjSif69LEX4I1VwnvnmzI4IDktJCK5KswfkRqf5IQwQl6FZqgQihG
 c6JftSo0G64LYIOPNSQjrsj9ambF2bqRJ7QS0Dk+6qn127SMFaVIW6V5khs8/Wg3sPui
 CVdP6fvCg42Rqi/Am7HftNvb7PAD/zrtqX1y+9xmYnrDbCNd2nQ6GyY8QCAdK3vNzf/Y
 imRyPppZvd6WDwieqLUYKD2+EWP1EsxKzl65URBBnRKovMP6Z5BHj7ckSy6RLACCL7uv
 dzSPiHz453dgp59MDoQWotpxiNzwYlGGCNxx6klaus7bhNrWiAjavIBmwp/H5adEjWC+
 a30w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnwEkcKUXwWjkdl1hNePNPI1IxmDfzFUIE3/YXGijlWd1pCB2szGXS6qVn/cgvl/EksY0FOxxuRvYS@nongnu.org
X-Gm-Message-State: AOJu0YweXcBr6efgqqCeM9F5F5vqtAQpWIIafTwOYWxVfFLrJJFwnRam
 fgwc56FhGpKTTGxrs97FhGq5dvRvUQrMnPHyu/t1hC0oUXdi5XbiuRhOtFqMlOi01uqHLut/6fj
 Y179ZvLX3V2oIGsGNGzozTIWprCjG+0EawGv+0Ane0MaPXn4vFeBDdglT
X-Gm-Gg: ATEYQzw/l6TOTTusEJPKwW38OOQnAMozFpnj8q6Ez7YaeTLPZw142+Fj5q4Tdy10aYg
 PFByVuTMgGWWqu0fCMdZEGCutXjZaTa5PCPZhxnSYS9PpSksewgIg/ej8x3XBG4Y6JeIB3DlEVp
 s7cHUp7lLapQaY2EKv3rk/GkC7QPzt2X4wQkdolFUrP9cBkYU0qwuYJXZJ+lAveztnqZlE6ajTL
 i0haTMmPz7Q+1YYfCBV8GuCvUc+zLYxiy85w5Xqi31MAPqF3txnO25ATCJNzPTZFEL1AzzJDUMX
 ex5JXOD93ri79VTOZPwI/IrhmfJZATU8mneUQ+7lIcgoyBsWaMmOiMQPx00kipk16maeXEesdlL
 z1kNQeWWMWhimsuOFnYsnHRO2JfDr6l5lsB/J1XI378xsoGtdlprjOtZD9kmmo2o5OVeqh7ByT/
 UEloMi7XfV5v6mXZvHCFnw4ez+BJ1XEPxFCxFGcrNfTwApvOoA0Cs=
X-Received: by 2002:a5d:5f56:0:b0:439:c24b:ec15 with SMTP id
 ffacd0b85a97d-43b805316edmr525843f8f.5.1774285061697; 
 Mon, 23 Mar 2026 09:57:41 -0700 (PDT)
X-Received: by 2002:a5d:5f56:0:b0:439:c24b:ec15 with SMTP id
 ffacd0b85a97d-43b805316edmr525809f8f.5.1774285061216; 
 Mon, 23 Mar 2026 09:57:41 -0700 (PDT)
Received: from ?IPV6:2003:cf:d737:d03c:df99:cbc9:b444:8cfa?
 (p200300cfd737d03cdf99cbc9b4448cfa.dip0.t-ipconnect.de.
 [2003:cf:d737:d03c:df99:cbc9:b444:8cfa])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644bd923sm36702213f8f.12.2026.03.23.09.57.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 09:57:40 -0700 (PDT)
Message-ID: <222c5153-0f83-4288-814b-698caa5c8f3a@redhat.com>
Date: Mon, 23 Mar 2026 17:57:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iotests/041: add test for mirror with throttled
 NBD export as target
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
References: <20260318165446.709541-1-f.ebner@proxmox.com>
 <20260318165446.709541-2-f.ebner@proxmox.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260318165446.709541-2-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 18.03.26 17:54, Fiona Ebner wrote:
> Mostly in preparation for commit "iotests/041: add test for duplicate
> job-complete with throttled target".
>
> Use a second VM instance for providing the NBD export rather than
> qemu-storage-daemon, because the latter does not support qtest for
> stepping the clock.
>
> Use copy_mode='write-blocking' for easy checking how many bytes were
> written in a given time. In the job's offset, the numbers are
> inflated, since a 1 KiB write will mean copying a full cluster of
> 64 KiB.
>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>   tests/qemu-iotests/041     | 155 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/041.out |   4 +-
>   2 files changed, 157 insertions(+), 2 deletions(-)
>
> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
> index 8452845f44..7b4a701aba 100755
> --- a/tests/qemu-iotests/041
> +++ b/tests/qemu-iotests/041
> @@ -1373,6 +1373,161 @@ class TestFilters(iotests.QMPTestCase):

[...]

> +        # Check that requests do not complete faster than 1 per second. They
> +        # might complete in batches, so do not check for exactly 1 per second.
> +        for i in range(0, self.reqs):
> +            result = self.vm.cmd('query-blockstats')
> +            assert result[0]['stats']['wr_bytes'] <= (i + 1) * self.req_len
> +
> +            self.target_vm.qtest(f'clock_step {1 * 1000 * 1000 * 1000}')
> +            time.sleep(0.1)
> +
> +        time.sleep(2)

I’m still not so happy about this sleep (in the loop it’s fine). What 
exactly do we need it for, what are we trying to test here? It looks 
like it’s testing that the throttle driver allows the right number of 
writes through, as it should, but I feel like that should go into 
another test that uses null as a back-end so that it is not prone to 
flakiness. I think here we should just trust that the throttle driver 
works, that is, maybe just complete the job under throttle? Would that work?

Hanna

> +
> +        # Check that all requests are complete.
> +        result = self.vm.cmd('query-blockstats')
> +        self.assertEqual(result[0]['stats']['wr_bytes'],
> +                         self.reqs * self.req_len)
> +
> +        self.disable_throttling()
> +
> +        self.complete_and_wait('mirror', wait_ready=False)
> +        self.target_vm.shutdown()
> +        self.vm.shutdown()
> +        self.assertTrue(iotests.compare_images(test_img, target_img),
> +                        'target image does not match source after mirroring')
>   
>   if __name__ == '__main__':
>       iotests.main(supported_fmts=['qcow2', 'qed'],


