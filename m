Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF00FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHI6g-0008PP-0z; Mon, 27 Apr 2026 05:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHI6d-0008MZ-FK
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:18:19 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHI6b-0003qW-KN
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:18:18 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-65890a6ca20so823622d50.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 02:18:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777281496; cv=none;
 d=google.com; s=arc-20240605;
 b=QGQGsHINeVgTwPCmPRZgC9/HNpMTXohcHmqrttuyDstK+KT/0BT48mi7sVFpe7/bSv
 aVXjKwkN7JxYbql13AyYHrdU4/WLtSxf4tkrIPx24xS+rpYDhCn4Zim6Dhz61ZUXi5Ch
 n5o0e1N4r/w5R6j7AQJNJQfuqJ+RTN15F7nSYJd7jE5qZOIuITf7sBw9QP49FNdgPeN6
 N8kuh2WFUQan4N8BPfRIA1YtP6SAfYCmQOMIleltPV43dY1nMtjgEssAkdMgWho+WLsl
 S1uPm3ExdD/iGZ1cIJHC2KUrz9ZgYpUtkImiujduQz3KLuF11AkLB8r5ih0LsIOefZgJ
 ZieQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4ZHD1rGHL9UN+4M1rvTNcKlJU3aVRlSVdfrxvxlbdxs=;
 fh=llxoylC/x6Y01OIXJwYMN1+j9TCA/JbhDu5Hy7C849U=;
 b=eBvA3JTuNSxDCdAO/qcNDXt6KTS71Aj6ztnogTUWWLQCFeYk9WgCUOCbMj7gi78g7Y
 CMRxjQguZV2zNPgGulNhPhvmc9m21U1O4yL1y5tPI3i5DCS7Akj2A5NlLu0r69meDLau
 DYxTS2eWjddNBGX94OVs/jj6qvAUo9A0RaFpAag0/tYqvbXmgCHNh/3SOq1xRx7vwoff
 oexU3KtrcGEQ0v4CJGU/VUN/u+s1zuW98qWR7bq6OGgNhl4T4CdQlKewpGyjBCvDhk4n
 NTrYHlMbai5xZCTfOuf5nvKjAv9jWXTjN0mr5qlrb312DbCECzx24DL1J1Kdzb8iKKM6
 O0uA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777281496; x=1777886296; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4ZHD1rGHL9UN+4M1rvTNcKlJU3aVRlSVdfrxvxlbdxs=;
 b=jU7FH2cLaKzhxubud4UN01mD+smE3fKLYUUyd1zZEhSdXGUKEWC4SwP6dAzEaP3GyO
 bJ+rOnfi3N3niuhl7EnBvqV83CyhPyz0RfSgj1oCcCDJaD9ypWVgldUGE34KTxYR7Ab3
 nb+j7uGRFSaTiY3zbUxlM5bABoMhPLWrXYx2sjcVr7gMly0rEr9xqZISc3j7q6DI30Wi
 lEHI6qgyheGPHyUDKT8bx45ANz2iAZzIWpiCPg8S5KlY4PAuSWBnn2CNsVghQ0ggO4R4
 AgChry8A5RtruiXd4Eli5RgohPnR8+quad5dWHRlLtyU35/+1h0pvUBvl4u8Np87SIru
 2bbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777281496; x=1777886296;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ZHD1rGHL9UN+4M1rvTNcKlJU3aVRlSVdfrxvxlbdxs=;
 b=dLeQu9KSDt7eAV8wFBf8dxW38TyXsjF0lbIQ306cjqLpjS2XNizqet6VYSY12+TMGs
 WjLBN2014s55+dO4dmCOxDFOGOugB7sexIi8D87K8JxFgP9NwrAwi45cRoWZhv8f+M51
 /99z7feXWl9xn0esDXIHRt4t67wANNpQ5tGCU5eAywYrBrv0aubyGR/Pc+R1UH+N8OnM
 ADnwJbOSIZW6nlZ9PP2OF1FTP+aYUIiCvAyIKQPAo01WpDzrjHMeaJzuPwbcDF3b6M2q
 B81eT8Ezsb2D9qdMrsFbna7C1/fQFtVn3enAHF50IkE9erepQ9OkO0yOkzbUWfhb4qpD
 n2Iw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+LwYKHMBuVT2pUjWrhUHVWNLoiW67DGjj2ebYKlNzR1LWUqUX3oQ4SY/xeH0Lm3uU8nWNrNT0Eudem@nongnu.org
X-Gm-Message-State: AOJu0Yy6MZr5jpMBBhL3yDZdW6m+uK59xWEUvp9rK8LAbH2RFN82e8p+
 hpmdhvYtpPOfeSMHWCfLj0QK6c2wCyD2lReCe92+Vk5iJ+4/lxVYkOaZIADjq3DVDyVDSUm1+v3
 /vBL3Q6Uyv+daVEkD2v4i/nVDOZfPC8bLIwwE4Y20KA==
X-Gm-Gg: AeBDieuOb6Mim0f26O7XFDU3GweEi5+EvDYyjR1hhfacuz2ChAt/HQ68iK+O6jaat7M
 TLm9PAjLd0qJHiG2kjYx64UEzObSTTNuGX++NpfB62x0dCbcNSCT+RNv7gmqkbdJ170+7/UKz+A
 LATte9QqzRzqJt/znc5XECxuyqB4yuWS8/KzybA/38kyiR/fOJ38ine4jhMHgTrk/S9yR8EPExr
 qTkow5711GTBPDU+/5ynBsEabC7xq8A5+g2G7MfLIDur4w2AXOH55cwveiJPcXowZEdYGWWBpAa
 +FdhhrzQmIhDgFV25JLRnWhAEQ7EZ4WJizqzrK0pWO9z88RlbFQglaluF1gKEtGvdvyRjDXGa0O
 cUXKh9DqqhkF2
X-Received: by 2002:a05:690e:b8b:b0:652:f16e:952e with SMTP id
 956f58d0204a3-6531080a41fmr36002187d50.14.1777281496623; Mon, 27 Apr 2026
 02:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260420140552.104369-1-eric.auger@redhat.com>
 <20260420140552.104369-6-eric.auger@redhat.com>
In-Reply-To: <20260420140552.104369-6-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2026 10:18:05 +0100
X-Gm-Features: AVHnY4Jk2G_QaUXXF-ToRhKsty7cByPhEM1z72OjTIi4V98G6qYyhT2FKUf-ujc
Message-ID: <CAFEAcA-HXmw8Jj2roq311B8-0VLjO+-vWO6yDpJ9UkpiztWO7Q@mail.gmail.com>
Subject: Re: [PATCH v10 5/7] target/arm/cpu64: Define cpreg migration
 tolerance for KVM_REG_ARM_VENDOR_HYP_BMAP_2
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, sebott@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 20 Apr 2026 at 15:06, Eric Auger <eric.auger@redhat.com> wrote:
>
> KVM_REG_ARM_VENDOR_HYP_BMAP_2 pseudo FW register is exposed
> from v6.15 onwards. Backward migration from a >= v6.15 to an older
> kernel would fail without cpreg migration tolerance definition
> for this register. If the register is present on source but not
> on destination, its value must be checked to make sure it matches
> the reset value, ie. 0, meaning no service is exposed to the guest,
> hence the choice of a ToleranceOnlySrcTestValue migration
> tolerance.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
>
> v9 -> v10
> - Use ToleranceOnlySrcTestValue
> ---
>  target/arm/cpu64.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index e7014022df4..a93ad2da5ad 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -834,6 +834,17 @@ static void kvm_arm_set_cpreg_mig_tolerances(ARMCPU *cpu)
>                                       0, 0, ToleranceNotOnBothEnds);
>      arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 10, 2, 3),
>                                       0, 0, ToleranceNotOnBothEnds);
> +
> +    /*
> +     * KVM_REG_ARM_VENDOR_HYP_BMAP_2 pseudo FW register is exposed
> +     * from v6.15 onwards. Backward migration from a >= v6.15 to an older
> +     * kernel would fail without cpreg migration tolerance definition.
> +     * If the register is present on source but not on destination, make
> +     * sure it has its reset value, ie. 0, meaning no service is exposed
> +     * to the guest.
> +     */
> +    arm_register_cpreg_mig_tolerance(cpu, KVM_REG_ARM_FW_FEAT_BMAP_REG(3),
> +                                     UINT64_MAX, 0, ToleranceOnlySrcTestValue);
>  }
>  #endif

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

