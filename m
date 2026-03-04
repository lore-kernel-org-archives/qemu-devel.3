Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F233EB7ECD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 11:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxkN1-0001ZJ-5D; Wed, 04 Mar 2026 06:26:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxkMx-0001YQ-H7
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 06:26:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxkMv-0001yc-Sr
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 06:26:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772623580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QMXT8d5Lml4DLjLifj4U27umQCqjL9FvvU+sCwSpdZA=;
 b=KkhWRM3Dh8o1hg+dVKWAnESWZTOD+rH9WdC7G7TyLqCSkEQ/dpt0+3UTUIfH5W+0thhco0
 T++EaqWk/8Q0JOtdBe0AiG9d52y/Ns+2UJz21WAKTyDxxfJc7/CegzBSljtHvVN8JyhHKi
 vcWeT/4ItNCJKK/z9CPPPi8Rgw7DETk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-VtwG4yyQOPmUkDS2HkVPkA-1; Wed, 04 Mar 2026 06:26:19 -0500
X-MC-Unique: VtwG4yyQOPmUkDS2HkVPkA-1
X-Mimecast-MFC-AGG-ID: VtwG4yyQOPmUkDS2HkVPkA_1772623578
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439b8bc43aeso2088855f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 03:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772623578; x=1773228378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QMXT8d5Lml4DLjLifj4U27umQCqjL9FvvU+sCwSpdZA=;
 b=eLUqg8xh4SbrTiYFBN/dL5Kd1ia6VA70TXLh1V6XiUrAwcoibfFwG9BYdoEfKzvTlu
 4eHme4fkyI3jeTHWx0XY+htYMfHFcDUwdyZONrjOItT4aOHj9MeUbcLzA2mWyoOffYpU
 XlXDV3xSI4VBQIdhX+PhzDnIJQNqNXQIWpuN+1dAv9miB/s8yxGZ3weLfKSjCupWot1o
 aums8S1ufgH2ScSjUjamDVDpNMyXEvmFDWL3+yUKtXvXr0fP5ChyAAGtzQlQ9xhaIWJR
 GmT157+vEabReXOGRRl6mlnhfMZLz2bBug6k2hIgdbsVgh71YoE8UfDd+XSZ6+Mo4a6p
 uiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772623578; x=1773228378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QMXT8d5Lml4DLjLifj4U27umQCqjL9FvvU+sCwSpdZA=;
 b=j0D11DIv6i+wsSmDm3WOSlhvjUCugs8i+HdIC5WGzhgT52wzy0HF/pRsKoZNQ+/i02
 tXZ46EAsiFSJXVnycNRnhuzor1DcUSf/w6JK0ozEoVJ7gNYbTPn7YyjvtSt4MG6AXqDr
 Pj6ws2XVqOfsZMk+g/wXlxxWXqgCpapjhQ0Rqbw1jR27GVjyk2a9Ub3nCHN7p6ZCRgg6
 zba2EwOBJtxlw4qkJK4RU3qag+2sdMPnohI8ih1Ezf0aVUTcXn9c8c0mN9hJJ681Za2B
 j36v32nKo3uoFz+ZrXBmuyAyj9aId4JpXngSaRzhmhgzASjzgZeYN5sqtHskI5jleVN1
 Ir3A==
X-Gm-Message-State: AOJu0Yyl1HKvUmvv4JpDEHBf5pJ+se+JXQfHkVA0r8Z29rhxzd+8fapJ
 iqeFlDr7jdGI/cMnBkgGwevYVPpi1HujZKkO87Lm5WzBexfOBmCxkwqcgiA3U+B0C/BT2+9c+Ql
 3OrWRI6e59lAAJgtH9DpO+7cmIAvvwf/ITHo0vdkDVVhDjewumfb6YhRf
X-Gm-Gg: ATEYQzw5y84Eq0/UU77q7xbQggujQQ7Bbu7UqcLBRRxx2cMkXMS0bUC2ttchHWaAmp8
 tnTFa/kGbUfjejHPwegNxo/y324tX/ZvlvxWWcRSK/w1+yyaE4hmOJfnobNNo4wNHcNEZ6wKqtZ
 4lRi2TcK9KSlCBUv6TGq2q6Nk6utPDC5jcKOrfrEdtCMnGP11EZczOvz2W/0Gjzb+KSa1N4fTvC
 smJjUyJOlMR3OvrPFB3YZi6xH2Po2BpGyt1imdrh8pb7s2kSuJvXfrD6EEULPWCH/VKJGhfTm1X
 vN21T0662kmyICYR7/KD8aw+Nwfhz9dUo6BysUR2alxOOfuHt/s3zNLXJE3Sm+4mBUQSKX2VUt2
 OruvLKQ==
X-Received: by 2002:a5d:4ac8:0:b0:439:cbfe:7e9a with SMTP id
 ffacd0b85a97d-439cbfe7f65mr324123f8f.2.1772623578238; 
 Wed, 04 Mar 2026 03:26:18 -0800 (PST)
X-Received: by 2002:a5d:4ac8:0:b0:439:cbfe:7e9a with SMTP id
 ffacd0b85a97d-439cbfe7f65mr324088f8f.2.1772623577717; 
 Wed, 04 Mar 2026 03:26:17 -0800 (PST)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b4175fd2sm26577178f8f.14.2026.03.04.03.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 03:26:17 -0800 (PST)
Date: Wed, 4 Mar 2026 12:26:16 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Jason Wang
 <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>, =?UTF-8?B?Q2zDqW1l?=
 =?UTF-8?B?bnQ=?= Mathieu--Drif <clement.mathieu--drif@eviden.com>, Fabiano
 Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 16/16] tests/qtest/test-x86-cpuid-compat: Remove the
 test with the i440fx-2.9 machine
Message-ID: <20260304122616.2485ebcf@imammedo>
In-Reply-To: <20260225092024.794595-17-thuth@redhat.com>
References: <20260225092024.794595-1-thuth@redhat.com>
 <20260225092024.794595-17-thuth@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

On Wed, 25 Feb 2026 10:20:24 +0100
Thomas Huth <thuth@redhat.com> wrote:

> From: Thomas Huth <thuth@redhat.com>
> 
> The machine has been removed, so the related test can now be removed, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/test-x86-cpuid-compat.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
> index 5e0547e81b7..c534e764f82 100644
> --- a/tests/qtest/test-x86-cpuid-compat.c
> +++ b/tests/qtest/test-x86-cpuid-compat.c
> @@ -343,17 +343,6 @@ int main(int argc, char **argv)
>                     "486", "xlevel2=0xC0000002,xstore=on",
>                     NULL, "xlevel2", 0xC0000002);
>  
> -    /* Check compatibility of old machine-types that didn't
> -     * auto-increase level/xlevel/xlevel2: */
> -    if (qtest_has_machine("pc-i440fx-2.9")) {
> -        add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.9/off",
> -                       "Conroe", NULL, "pc-i440fx-2.9",
> -                       "level", 10);
> -        add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.9/on",
> -                       "Conroe", "erms=on", "pc-i440fx-2.9",
> -                       "level", 10);
> -    }
> -
>      /* Test feature parsing */
>      add_feature_test("x86/cpuid/features/plus",
>                       "486", "+arat",


