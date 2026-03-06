Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C251AF01814
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 09:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyR2f-000789-FV; Fri, 06 Mar 2026 04:00:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyR2b-00077T-DK
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:00:13 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyR2Z-0006fK-Tp
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:00:13 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64caaacb9bcso8600824d50.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 01:00:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772787611; cv=none;
 d=google.com; s=arc-20240605;
 b=aA7IMeupkozHKr2RI1i+f7tZhZ/bbveYW9w8fBHBK/dvzICzK3p0EBXdxmt/zwutrI
 3BJnYELe1+AKl+KCyGPehFwskamIHV2x20vzcm/TRpPJbR03ugvh+sazVZJ6Yn2bKVnb
 0Now7kojpBYb7btviKt5fOhu6lW8KvciKZmeR3z/6NZYGMRDAsywsd24qB4ET3Y8gyod
 njRMqsZ3gt6ostqFIrWKgZdCN8USRo5L8B+5l2LdcC6Rdjf+rt0kpiG1X8Yut/6UF7Ik
 8eWeL/i2Jr4Qr/Lnw1u0aIAdABzha2j+tUvSdQU5txENCLnPMuyJ9RNp1WCQUeI8PIB4
 kzNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=O3K2Yjwdd+NswhpL/XI4IFWHN1bXQ9BTL3dCvM9QBCc=;
 fh=VqS+tPLsGlswY454e0dYtkegTr3u8RL39VDhCWIP5Lk=;
 b=UkXho/XzlwR8G+xwtLUNykr2JrsHq2qg0h8NKwFplmBrdzxFELvx3Pjahg2FDJ3+/x
 V0IwkS2Kk7/Vly/TNRj+3EGyELOFASZPlI55zGJfOi0FIa8IqyBDZTLJjc6qQUUrjmZj
 AHXlttaaxtKtDoAenoZOJgWSTHjw1O2YOZf3s1sfOqfL+wieItdg5a0JeaEd1lWlqlyG
 JgH5YWrGrYyWKaaTJGMk7g/4DbN1YFM4bwG/F0l5s2uSAxpX2W0BBNHYz3ZueKp768nb
 yA3Tp6F6YRnhJZlTF/5N80t1FezsROmkvYEMN5GIpciB5h+oYtE234EbTA1c4sDbC7U7
 mIYA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772787611; x=1773392411; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=O3K2Yjwdd+NswhpL/XI4IFWHN1bXQ9BTL3dCvM9QBCc=;
 b=mCt0j6avjjVAhZzobeG+4KHyNMDAjIEyq4/kZWu8lE3US8rxWN7IaNwK4t7NkG6ryE
 2DrctFblihcP47nXb8GMXs+gdskWVK/0urheEaghv8Fz3oFRovwTQMj/UGCO8/xg3y6n
 A6ScoG91hYLjwR1orRlEXA4+NrHEv5DUCwmB6reNte7AqRBM80BAcH9Es2AFqN9X8XDm
 zLEO9VdjfOLJlLBMJcNpDvrE9q13+71MOugiD7FZ4TOhigTUWGOsCbNbXpIJCgo+dpG/
 xUiymk/NDmW8V4Gaq2dDHHQyrI5QvpnOUuEe+SgwCDF6FLSgDuNRSryHdsezyaa+Ut2b
 O8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772787611; x=1773392411;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O3K2Yjwdd+NswhpL/XI4IFWHN1bXQ9BTL3dCvM9QBCc=;
 b=inam7exdZb3wTi+VAhPkXAMqET9o7HNRAXAJHAbJ4d8xJYxTDnsVO7u9qDAqWzhd56
 +YT4p8gmNmRSsiSyso5KsJzaHdxrGLFOZ/aC2YnPtNShTGya2aApHOJ9zqP0gZnFYikg
 0ewyRzaa4HVRJ88f6+YsZjioGFpnE95N0z632fT9ya8pLi/+m7wBhqoy0VqTzPWRNW7W
 HS4P3jM6RG+a9GJoLzHtyy8/ow+wDRTT797d31INPeZOO3vjFVrdGDt2+7qm0YtBPmFV
 AIm7MQVHLcP2QOfXMeobK1Php+Ez4yDVw7aRHm2tNH/xRugQZsf/6130zFh61ueVVQoa
 qu7g==
X-Gm-Message-State: AOJu0YzH41c25EZG4q3cobJVGv2jlf2gT+eLusl+KWk/y8o21iwjNSxd
 GNrWdxPUbktW8eY44uq+M3L/QUpVv4r5Z34yW96Pwo6Xmrsjquf+G6arM1pGy50y5MN3/2a/m19
 bthmZaQYQjUqlqePTFjm4OTWSB84N1uC/V2TKOFXB2FDXH2/DePwj+fM=
X-Gm-Gg: ATEYQzykvbErQ+k07vjQ7j4VSx9G0S6mPaVroi9K6oEYzCI1rGTeb/rFazsIw13EpzC
 b7atQCydRAKFxnXJeg4KOCJWEuI6mN0Mc/a8XL+wKZWZJ6wq+l8bg/xa1vVpFj+8WuePh0tJfVC
 Ci9wBSuoX9tSJebUtYaou2a6vStqzVcSAL7ZDa3KNuQwTxw8wgNVBrYfd0Tr73St3TS3CdS+nW0
 jaU9Hyg83DTX62kmcVq7mBimTHM5vTzTNFv1SDpEfn+N3DCz1PIY+fqBGxw49Mjox7ekRagnVYF
 d2K3hDQmRl+mY0ckHaDPagAz75m87VN236Qmf4H7E44vFxZyTyK+HkdmX+emUGCKSqc=
X-Received: by 2002:a05:690e:6c6:b0:64a:e7e0:a723 with SMTP id
 956f58d0204a3-64d1407b433mr1019817d50.18.1772787610602; Fri, 06 Mar 2026
 01:00:10 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 08:59:59 +0000
X-Gm-Features: AaiRm53jnM1UFht-Hs9u6YFR6g3-uuPh2_38370UOiIps2A_mt3WvS1XbA0qCjg
Message-ID: <CAFEAcA93-RBUZJmDN_i5c31sjuJrkMFKvAjDLh=yWpdchmVsjQ@mail.gmail.com>
Subject: reminder: softfreeze this Tuesday
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

This is just a reminder that our schedule for the 11.0 release cycle
(https://wiki.qemu.org/Planning/11.0) has softfreeze this Tuesday,
the 10th March. All new features should be in a maintainer pullrequest
that has been sent to the mailing list by that date, please.

thanks
-- PMM

