Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E359C79FBF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 18:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4j8G-0000wL-PC; Thu, 10 Sep 2026 14:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4j8F-0000wB-77
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:04:19 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4j8D-0003yE-Oo
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:04:18 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4b3a61bdf22so62397b6e.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 11:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789063456; x=1789668256; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WpIBnjhKubka7+O7p9SF4B58LKksOAZsX852SDo8IXY=;
 b=jpskzUDml1jiLy6TKUaxdi8kQ966QBeIkoZGwvDmxrX8rwiInuUD9ngkIUv5eeIa0i
 1IejAG0Ej4YBGlIzETBwhoU+alPHVvtnJbihoMxyhieUX6FAL2X0bKf9dinErs+v9E0g
 CplN/ovkm9Y018SVwUkG9CLP9zsUwoarsqlNhJeRA5mfGiBjuzHJV2VljRGhwqzT4AON
 80Sy39uC3oXxlQRpkwEHwCEm6+BglEpPcQ5oUwEGNDJWPi06Q6p11E2L7HjJU3tFCdj9
 jCMoDgZ3PUgM4su8s+noMmW/YWL1w2yQFBEaIQIXDcXk1m/xMUA5dwCVR1KlXtMZ8Jbj
 zquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789063456; x=1789668256;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WpIBnjhKubka7+O7p9SF4B58LKksOAZsX852SDo8IXY=;
 b=DOGMedELh99rrtaWD9cS1yLHnRRENrdqlC0SQamb3hg2ZjzkIPCE6+tAUpuItb9xoZ
 Pb+roY+He3rgBgMfJqmUW3Ys9qWVExUSp67CXZ8iBFnhYgA6JAaHkkeNGJq3PqY1wpY4
 sv5tT3V5rZWbI6MKwG4GyqiEEI38NgtOlG0vOQ1Aa521IHKgmzmlhEskQcEVQuGj5Lmv
 NOi2Sw81z+Lel623tHYeysHJzNLTkxNQmeISOq1D5zZhp/Uf5Q3tK2IwN/RUhMn2kOtv
 DOr7shtKkpx9cKMrQySCj9fZjGsXg89hQxI0+PS8WV3i7QMeVOx3s060BwyyJnwghKaC
 ygXQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxECA6Vziq41IibdVDI3eNRar9h7g2qwodBwREoL/to02cJNKEfJpZeVy4H5egGT1F7yWqESWv6FddF@nongnu.org
X-Gm-Message-State: AFuF++ncIhhNyiWfuclDWEGfKtQuil080gU8n/E6OR1HidWiyA5/KU2z
 wpDp/PNmINSCsstpV97TUq0vzK7nAtqQH+yxcCaFungC5aN+hk0znsaM1Q5TuTrBNNM=
X-Gm-Gg: AYBFou1nXSjXRDHfR8zAETrfdqg+iXHG0SMTVU/ZvLylbFBUcFn6BZzDmomELXFlKQt
 07u68jcXnns3FEJMARkO3d1ahKkiq1OmC0O/0f386SJLKqUcwEC4HE32xLf+pnG059aFCqO3fTu
 /W6pCTlWl+Hn9b7SHOrfjAPX8QOQ5qvMzLf4csj5sQILRk7ArPYZzmkokwOsf8leT1pJUeNL11g
 NwjpIlqdlbKf5aUDmdoq3ppiCdNj4PLcsRA3iE14j765onMO42xUBd63JRZ2CoNdVgSYurLznTT
 WXoVI6Sn0xq4n3WrdWkngusdfmj3dLbD5P4nMQraHeWGOlQaD90latuac8Ia8ibYaSLfZQQ6uej
 rbO9gyfRROvhSJRAv0tNtkMLyCRDtz663IbdQ2rQ8Vzz2K2aRALObrmDb8VpX4n32N0X+R20n6G
 c0oqR7bkLKpbHojw3p+TSqjKE/FcC9HURKDtD7KlnltepZTtn0c+H3P9kSp/BBifylbHEFtGQ+b
 K/gNjIiQKsb68c=
X-Received: by 2002:a05:6808:2e46:b0:4b9:a88b:888d with SMTP id
 5614622812f47-4c31c725778mr179360b6e.35.1789063456077; 
 Thu, 10 Sep 2026 11:04:16 -0700 (PDT)
Received: from [10.171.0.227] ([98.155.112.169])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365ba729dsm393615c88.14.2026.09.10.11.04.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 11:04:15 -0700 (PDT)
Message-ID: <8df75343-61c8-4af9-901b-0e388a029e1b@linaro.org>
Date: Thu, 10 Sep 2026 08:04:10 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Bump min compiler versions again
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260903103548.2142568-1-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260903103548.2142568-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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

On 9/3/26 00:35, Daniel P. Berrangé wrote:
> We could bump to 12.x and force NetBSD users into use of
> the non-default versions, but the last patch took the view
> that we can just warn that use of old GCC versions takes
> you outside the security policy.  If people prefer the
> former though, I can respin.

In patch 3's commit message you mention that NetBSD has clang 21.  I 
think I'd be happier just rejecting gcc 10 and letting NetBSD compile 
with clang instead.  If someone really wants to build with gcc on 
NetBSD, they can take the extra step of using the pkg version.


r~

