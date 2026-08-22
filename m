Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A60C5DF97
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 21:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxswc-0000yf-Ct; Sat, 22 Aug 2026 17:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wxswZ-0000xx-IO
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:08:00 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wxswV-0003TX-3B
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:07:59 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c207cb16cf5so347561566b.1
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 14:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787432864; x=1788037664; darn=nongnu.org;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ow0qivb23ryyYSnNhnEBLMa+Oms9O2kAQTIOS2JoyWA=;
 b=qmFfDhzDOVOy/nS/LcpaM3q6n44BjKb+7NxyqRgafkX34IEW9bBx96X+sW+qKXHnL4
 UjRQ6pB4AEFILrh+fFh9fOyc2nSdorzWM8fae9OaLrMz1/pmW1LuhkZrDiQ1pNRcxxcq
 vAMKzuVsBgmNCoY1PwP1LTqmT1sEQhKu4vCQ/4nNSk2dk8Dk9GfXW3mX9BQ3s7lS9N8S
 eC9Z7HApRF4gQfUt7ilMjt5Su6ifSGbGlFb6Q0WB5U2mHAKZRuZz41n0OFTr0v4tQCCf
 hU813QKmziE5VrBEgqu7CbFvxLtqtk/dC3Tal0h2057HK+WnFua2AfxudI+MGRL6teHH
 0tEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787432864; x=1788037664;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ow0qivb23ryyYSnNhnEBLMa+Oms9O2kAQTIOS2JoyWA=;
 b=bFSJyo/3uyLHESIvUmzX3gNmPTFBMkF+QfDhLb4kyRWVe3YzfwH5sNSFgxV98U1WNI
 P/XjYeZi18BRWe1EM2xX30nfQK9AscrJdcCxFO9Bh49QRD7eOvqZCk0oMlJrqD6n0cB2
 mjfumLtj0dxHVt5853TGL0p9DXB00lBnMHtE8SzjB25yQHo3zNhPvktPxVDygIEAhFbz
 LK/vTNOaYTar0D2KrIwh9/ndJkSoOTvBPYM2uWTT5iPS++F4agBO2a+5Z5KOqHFsD5/T
 NNdewQNNBySjoJ4yodzBG9Od2TnO2C62M9DsKLWJ4eLd7Y+OidDqHS9eDbjZKVcgomJ1
 pfmw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3uItYmoG2YUk6vsHH8hE0uUe+Zky+aTe9IQvtxtuk+38aj6MbMyKr/T9wQAoEeBnAucruvOzFq65g@nongnu.org
X-Gm-Message-State: AFuF++ngO/2D5I2IwFHR41JTnNT5IRucQxawlgTtW1jQ0gWFE07oB+VR
 wurDRpRCspC5nZw9teMoAq63sK07+P/sBajQKku/jqfqRqVz/z/q6hm5
X-Gm-Gg: AR+sD13kk+XiCj94L2omdm2q1XhJZ1oxOVX8fpjg6z0cw+PZM08SEx/vZ53E0iqhgIq
 cCLvw3J7DeRaaf/QzF1Lg4sZP86yil4yKIho4z5PxUkKY+6f2LCpkGldrFmmfZ/zUOZKJb28isW
 +KDGaXL27Lt9D/069YxW/BJMwh9qQaOoM70TsJJau//rhMCSpxfKISMy0KOhy7jiFxO2eyeSrTJ
 FIrIMJHkZ/0dGEEzaDoIkE6P+1lyQ9GTIs3XXp0W75lK7eJxtpN39irya05vjUYLnZ+HandotCW
 C6uYzINRrBhPl5cmrGK5lKf7aXHBKfHqXIRjgh0dpTb+0oPtV33i73QPmK3sN8tyCJB4fxPiK5n
 +n/d+B2hUkWVVwmln9bbwPNZWiIR6tbKQ3iecaEqf5HWAUOI7KDjDUh/wC+2AK541ypx1AKYdkE
 1BHuEIv1s/NSEanRFLm5bbOLbA9cA2//0Amk6pnyo=
X-Received: by 2002:a17:906:1005:20b0:c1f:97f3:7225 with SMTP id
 a640c23a62f3a-c246a3072dcmr1201222466b.6.1787432863742; 
 Sat, 22 Aug 2026 14:07:43 -0700 (PDT)
Received: from localhost ([2a02:8071:50c5:5c0::361b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24962a3c13sm518387466b.26.2026.08.22.14.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 14:07:43 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Nick Huang <sef1548@gmail.com>
Cc: bmeng.cn@gmail.com, farosas@suse.de, pbonzini@redhat.com,
 peter.maydell@linaro.org, philmd@mailo.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v2 00/14] hw/arm: add TI AM64x SoC and am64-virt
 machine
In-Reply-To: <20260821163515.12575-1-sef1548@gmail.com>
References: <20260820124824.618671-1-wafgo01@gmail.com>
 <20260821163515.12575-1-sef1548@gmail.com>
Date: Sat, 22 Aug 2026 23:07:42 +0200
Message-ID: <87o6etj23l.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=wafgo01@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On 2026-08-21 16:35, Nick Huang wrote:

> I think this is a good approach. Thanks for working on this!
>
> Regards,
> Nick

Thanks Nick, much appreciated!

Best Regards
Wadim

