Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4EACC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGsM3-0005np-8M; Wed, 14 Oct 2026 02:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xGsLx-0005nK-N7
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 02:20:43 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xGsLw-0006wP-0y
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 02:20:41 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49fbb2acc90so31537305e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 23:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791958837; x=1792563637; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=odC2w+//hTwiKziasqftRplHedV3NpRa6Q6gpapZCsM=;
 b=SazPdAsScEEch9EkXqFitnpgE5o5Ph27JyritV39bR02grxxjRGp+b5C5mXBL+gqvH
 5sEXo7ADBbza7OUblK160kr3lSnbAJVNez1Zb9W7xhHlHWv3Wb+Q8YVQpPiYBdKDPKZk
 7H+ZlE/bNaO7xittHfkgucOoSACpv45UfSYWJPSrdBi7aGww9OYWkKAnvPULruINlfz6
 MiQ5L9tbFQE/H9rdcTnGYqor8c0cBU+Uoe0nl6Jsmbjl4GjTcGi8doZEHcp/av8CA6I8
 7u9e2pEiiHKVt2SrDnVXAQnc2G0dfxdZ4UXUjj/Kvf6irdC2eoDb1T7Uwmv8/6j4KpT2
 WjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791958837; x=1792563637;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=odC2w+//hTwiKziasqftRplHedV3NpRa6Q6gpapZCsM=;
 b=M0y6xtv3rTwf9CW8TrdoULw+ziHVuDfm68s8rAMYv7eBeNf8OFZbokhJ4WkwSKEZCD
 evcFDeKNtwaVh1UdIeNwOD7TDOB+9a2sHteoNo06URH3YkYQadJiennp5IGOL+rsjyrj
 h1QIZfLHMByU4PRKj+UlxEuSFOM3alYZ//vM1Sk5oZ3Tw1kA7izj5IYN/PVggABHVbYJ
 f+QHnAhGHBSSG+/UveBvVeBUNB5BJRjwWLTaz60rq0N1TnPaAhxjfmIqpZnePhEkLKvV
 aSrZW42iFaxZCZ0FJJB75lV/k7Izv3SHIfnN+/iLFRPLkuuJXl49W+arcwVOThDIPN1Y
 29LA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxsIpCLDJ6/mxHmAzimZQEZuWeZekWGu/Dd825bBr8q9B9CagVVlEQrVI4wZICOSRA7RQDEoXaliyVv@nongnu.org
X-Gm-Message-State: AFq9FYKHxBwKnd2ohXR43XhGET5vjxAw9IlWT8t1UGkP+qaKrOxmx6Fa
 cZDPKlVBM381qejvlDkxThEvXS69CP+9cR6ZT3WhBSxR9XHxphmXLfUX7ffRCj8OHMg=
X-Gm-Gg: AYBFou2ZLPuo/dBzwYmSinMpP9FPU1sFzVoxM1RO/ChYTB4ILs/QzNjEepqUrV6fW8u
 MJYFt2EVDkLxBsP//f7rFGprxiH8XBLJTXtn6BHCO+UlXMmI97gnF5S5qvhPkBItatqpLPY/rkE
 bdibGdtuXsn9EaQ+RsNgkwZpEP37Qv4L+KpHG5JaYBa8J6bvRP2Ysn+DZSx4xuaWTJHBHXGbD7i
 LJtBwqfL4o5CuLxOLQf09SgZ4xWZeOlzk2erW2TGPEOki1p0/vB0mmQdAWdSikDlwoqUELS8Xns
 mBSrc/QxJjjEUnq5STWI+DCURtcs8edKOB4y+gsgITiwBEkk5NeA0tWI7qBBqCblN4sSisl1Qgn
 S/UJoAldw1NHv+I+L+nxYr55TfMJ0KKE1XiYAYTKGvBH95dLk6o6vTsIdkm7wVHyhaojRVRHvaU
 JKDaUgCYPjC5XPKaMVLUiNRc/kq9QrVaBAO5A4QqFtuIuOJxI2y3VpXb6NFL5q1/ahDJ8xal7Tn
 DKyUivuGNkMKUOsPG5wcj75UuBCX44XMiQuQnnPoFmzrP9byYjk2g/IPw1ZMrs1Sw==
X-Received: by 2002:a05:600c:8184:b0:49f:ffd0:4039 with SMTP id
 5b1f17b1804b1-4a18e4f2221mr253073475e9.32.1791958837267; 
 Tue, 13 Oct 2026 23:20:37 -0700 (PDT)
Received: from [10.86.151.227] (ip-109-091-152-129.um37.pools.vodafone-ip.de.
 [109.91.152.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18c1e33d2sm608057635e9.0.2026.10.13.23.20.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 23:20:36 -0700 (PDT)
Message-ID: <1f4ff4eb-d1f7-4903-9927-c1cd5c867d7d@linaro.org>
Date: Wed, 14 Oct 2026 08:20:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Deprecate using named CPU models with KVM
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>
References: <20261013105147.1070641-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261013105147.1070641-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

On 10/13/26 12:51, Peter Maydell wrote:
> Currently when using KVM on Arm, the normal thing is to use either
> the 'host' or 'max' CPU types, both of which give the guest the same
> CPU as the host.  We also for legacy reasons allow 'cortex-a53' and
> 'cortex-a57' CPU types, which will only work when the host CPU is
> exactly that matching CPU.  This is because the original idea of the
> KVM ABI was that userspace would request a particular CPU type by
> setting the target field in the KVM_ARM_VCPU_INIT ioctl to an
> appropriate KVM_ARM_TARGET_* constant.  However, it quickly became
> clear that this was a bad idea, and now everything uses
> KVM_ARM_TARGET_GENERIC_V8; the tiny number of existing CPU-specific
> target values behave identically to GENERIC_V8 except that they will
> only work if the host CPU matches them.
> 
> Future support for "show the KVM guest a CPU type that's not
> identical to the host" is going to work by telling it different ID
> register values.  Real Cortex-A53 and A57 CPUs are now all over a
> decade old and not in widespread use.  Deprecate the ability to use
> '-cpu cortex-a53' and '-cpu cortex-a57' with KVM, to get rid of this
> odd legacy corner and open up the opportunity in future to support
> named CPU types via ID register settings if we want that.
> 
> For any situation where the cortex-a53 and cortex-a57 CPU types
> currently work with KVM, '-cpu host' or '-cpu max' will have
> identical behaviour.  (Though note that if you are using "KVM, but
> fall back to TCG" then the fallback under TCG will be different.)
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> Personally I doubt anybody is actually using these named
> CPU types...
> ---
>   docs/about/deprecated.rst | 13 +++++++++++++
>   target/arm/kvm.c          |  7 +++++++
>   2 files changed, 20 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

