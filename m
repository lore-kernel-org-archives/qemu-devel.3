Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BFCC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 15:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgQjK-0006as-Ra; Fri, 07 Feb 2025 10:57:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tgQjI-0006Zz-0c
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:57:21 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tgQjF-0005A2-GO
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:57:18 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38dcb7122c1so666936f8f.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 07:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738943835; x=1739548635; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jqvGFtgLIcssDAnzxgAxV/XWOhETlMnJ77XRKC1k4ck=;
 b=V+bIe+2oCuvntr8IEcHzzgYsFgPghThHSClIc0u/KiroHKEOY1cS6KuReOy8B3so5c
 cp51Z7S675fOIAAb0o9kG23gXlD9/m01uFOMc2lGz7zXO7XkjQWwHHtERaKbFGLrxG5k
 oQTasLJTNM+4oDjPtGwUDh/RwoqKDroerxUw0JlDzCsmgEBThOPvmCvF5StU3ESUFR9P
 8EZcv/a1prhJVdpGiQq9mpg8rpQlKwtCV08iavFf6TZ06TCA81Ui2MlLDWku6MIJlx1S
 CBb//BhYf/S4DsPidKX0R63AHtDsls3MrbjBo463EmpQjKKMoQpmRIHTMmQACEOKxzim
 VUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738943835; x=1739548635;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jqvGFtgLIcssDAnzxgAxV/XWOhETlMnJ77XRKC1k4ck=;
 b=uvQdiuVC/y8WoarY3Arsse8mLjX6HNqCYOQDzDkVPV/Cd/Mr7JZeeSxpuoMqhfXraK
 MOqQzBt3zqFb8bO2bzu+fvbi+f4J+/onkzmp0+SphlKj8rj+nDGaQHqpdaV+6vmpktzL
 wE0noKh9IdCDvf3raYUTSth6gN+7ngSTcme3wzzMquxaUjV/Ekow1Db3BkJ3IFZkWUBy
 DfE468/6fkadhJ0+LJ41Xm1rsQJBF52QrepnLdeOmib7plNteZGlTfhb09ruKIE6HpZb
 f0Xa5RA159Zfl53z+U8fv3iIewSNQBhTlPYSvYS+bxnhV99vlPRvF6VMjHp2iwCgWKeP
 kQgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5xDBQsUbIwIzCO8KKSP7GBXqUs52+tU9QJm99SHrCKmkEJZayRrXFazqdGbPAJ6BhtbtCTPnSgCHe@nongnu.org
X-Gm-Message-State: AOJu0YzDpPngWUNkv39kaydFRqWF0wnQM7GxoI85akNyRcy+DLR/wLGH
 DWumwVy+okrMGYx+FEGLGUYN2MJxDaTGDOOFbFlQ3vyupFRPyruna9F0Ut+uioU=
X-Gm-Gg: ASbGncuaijuq7d/KF+bvgISKRcWl2L7xk8orPt7ce4hFyxxxIs31SQBIXXGRuPsGhcr
 R+69ib4SeyXveFo31Z564HtZ3JT/7IMUYE+Gyln7/grbYu9CtFIcYKVSDIPNbS+8mlyEkVfLKv3
 2WpqRM5XhzFDa/TIP0k+xNggiAjugBVKkyf+2gjbtiUHqMTldVvijNpTnbxHgjW8T957ZMEIK0I
 7BB9Tb2tTXMyallof+mNwEYougIoRNb4CEZNfqeRLUdEegDI/Lt5iK0A1g+WT+4DbSt2GBAaROS
 ZToi0h5LXQl17w==
X-Google-Smtp-Source: AGHT+IG0i0l5YpSBv7JUxMbvMfBfChO+FTI9m1yzLejFjQzYD8mDS4GA4acnoVtaTqBUwe2XXLFxaQ==
X-Received: by 2002:adf:e90e:0:b0:38a:41a3:ac4 with SMTP id
 ffacd0b85a97d-38dc937334bmr2151278f8f.45.1738943835257; 
 Fri, 07 Feb 2025 07:57:15 -0800 (PST)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d9334e7sm93748775e9.6.2025.02.07.07.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 07:57:15 -0800 (PST)
Date: Fri, 7 Feb 2025 15:57:39 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 philmd@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 alex.bennee@linaro.org
Subject: Re: [PATCH v3 08/26] hw/core/loader: Add ROM loader notifier
Message-ID: <20250207155739.GC3546768@myrica>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-10-jean-philippe@linaro.org>
 <73f81e95-7636-4a55-aa29-d288b20005b1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73f81e95-7636-4a55-aa29-d288b20005b1@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Feb 04, 2025 at 03:33:10PM +1000, Gavin Shan wrote:
> > diff --git a/include/hw/loader.h b/include/hw/loader.h
> > index 7f6d06b956..0cd9905f97 100644
> > --- a/include/hw/loader.h
> > +++ b/include/hw/loader.h
> > @@ -353,6 +353,21 @@ void *rom_ptr_for_as(AddressSpace *as, hwaddr addr, size_t size);
> >   ssize_t rom_add_vga(const char *file);
> >   ssize_t rom_add_option(const char *file, int32_t bootindex);
> > +typedef struct RomLoaderNotify {
> > +    /* Parameters passed to rom_add_blob() */
> > +    hwaddr addr;
> > +    size_t len;
> > +    size_t max_len;
> > +} RomLoaderNotify;
> > +
> 
> I would suggest to rename it to RomLoaderNotifyData since it's the
> data passed to the notifier.

Agreed

Thanks,
Jean

