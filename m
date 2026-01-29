Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10299D73E84
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 20:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlYaF-0000kC-OR; Thu, 29 Jan 2026 15:25:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1vlYaE-0000jI-Ab
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 15:25:42 -0500
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1vlYaB-000429-5R
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 15:25:41 -0500
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-50299648ae9so78911cf.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 12:25:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769718336; cv=none;
 d=google.com; s=arc-20240605;
 b=c6iJ5vtyeNutuEH45mRPJjYTLtbZQOl7/NFKhrPsixT9y5h4xnIUd9fcBt/SyB1LWz
 MIZaQdzGZm72B76kDC9UHV+1EhbSc9erYG7ohwVvca9v5Dnx7PA5j/fPmvwtYFa7W9bE
 W2FhLre6DaEOyVjLrBNSBO0oigDh9NHWCgzVCT8JyYs3sNPDSOOin3x1cNU5HGvcXtUT
 XizRZBbYGAnpe1g3Ttrz49uTNtuUaxLAul1R61zEelszfsUhXEVZ5zgnFEGHqlTagjtc
 7u8kNBPbKKuuBlf21VcYfjIfePM4e04wp0B/P0EsI/aEOdI39CmY5wr72SAOoolE4E+x
 n7hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XaAX1Yb8zbQEMHVP5QpIe9q+E5mhzU+A1GDWS720LYE=;
 fh=naDeSlug0dht5e2IztAOeyInAg/DQ32waWeI+qwA7o8=;
 b=RM9qa8M2k2c4yWYk4mj5arX3uEgH/jdcH6K+REVVxXlpVOUYYlQVEoJvYSK8ILvgCE
 caDcxnWlp56iu0OaKPbc4yLEk8wQbdm/50AhDVSzPYWmTSuPaEo+z9NTbTJCNNbKzxq6
 0l2zyThr67Pw77kTXUxd8T/K8btg0GXLTDQ0L79CPY3VWs0FVJbEi93wmEPh1ceN2wK3
 3x9x1d+vJtj2eyr7UuJbS22xlWByKYAmf724yIR/IXGMTU7jrtuFF/XIqQyYg4yM1jUF
 V7eJ9IvcezakN/yF6Rsfez0auadpJq/yxUi3/jc10oiWCGDeAKaFLaEoQmOl9DG75Nuw
 DR8w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1769718336; x=1770323136; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XaAX1Yb8zbQEMHVP5QpIe9q+E5mhzU+A1GDWS720LYE=;
 b=tr7XU8ZndMmKHqsWHVDJqp5+fd6Rsf9Te1L4iekOhSele4cJCDnaZN5NgABQm0W/TQ
 kDv/rC92IIKw5iYzCZz6TK+DRLYARZzir/aVBRVDM/zoHzSkvSnAr64yO2G2Vb4X6+Nt
 UWakUzgFtRDClOMVTJ7lsWZib5Ih2tIwB3+WjZcZMwiT4w4Jia9Ppz0miDTGiFGg8K6h
 OXFUTODVp7dA9W8XVH1I6mrHReZ1/ZHRcAqHy7TMOrAfmOrVoF3q2GVcapZaBMOmluVf
 TsH/CYQY6WQr+3lXraRaemoH+O5llWVzvh+jCQ+i+smsz3gIPGM4ClXHELu8nyE4nb9c
 n4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769718336; x=1770323136;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XaAX1Yb8zbQEMHVP5QpIe9q+E5mhzU+A1GDWS720LYE=;
 b=q6AsheQjwzo80X82u5R6i8lL+N8KnG0oGgCdzH/lL1vhhomUT137IKXBy7xdQ+jeYU
 SoP+IMaJtHUSv9yLn98B571SAYvenXjztxUF6xvV24zXSal1rVXYEaled0t8vcVlEos9
 SLz2Y+ttIN1dLNRYyOBMPDWwMJHSia4O58ydxCWSwb2w+EMcJNNo5nu7uPQ5sXEn+LUD
 r7UyWNCjFoD/tEcmcCHFr3Szu7ptkyrxE3rtaKgJCWbDwnJECm44ApPSv4fQ6obJ/4cg
 395+qfkiRH1+tDGeCrnHUiFh49kFTkC2hKcvfrLnLxS1jc6aDzsOd59StWDEeHfKaPNq
 1XSA==
X-Gm-Message-State: AOJu0YwISx1lcJKvD42cfktswMlYwFrYIsFh1VWhaA8Mw1duchSVZdz2
 9KEmUR7bY69RU89dhwgExi3LSHdmVn3q+o56jmEBlhs3If6yYAqRRRRGSXQXNaW/fQl6/R+eIjK
 RwO4c+9s+RI98OD519WgnYDqTl7aht66q9h2QPcdG
X-Gm-Gg: AZuq6aIskMfgN1TDdS/BoxGe+mCTDD5gWCCaSLBkonUHs6GwN18O7I2SITr1HtMTDZG
 fnmgtFWak+oMC0b0+Y1Y0d+TpLnwhqEZvPuUVQ23hjmWs7P1EzKVzDMQHr9qS8fT8eiRztUMhzG
 BtySiWKdYImq4AO2SSI7WifUrlp5PNxvqq54H3cAFHvcPxv3OSALI3bhFly0482d8OhPbIquR/w
 wdDaWyR9AVx93Q1+fx5cVU3Abj2PrMmEarp7yP+IJKIcTunrcFBne6q+kxC/DxFMh3Jx3b4NQam
 Ncpntkb6yZmENRerQ3g9jkzMIg==
X-Received: by 2002:a05:622a:1a85:b0:501:197d:32af with SMTP id
 d75a77b69052e-505d282fe19mr965751cf.0.1769718336027; Thu, 29 Jan 2026
 12:25:36 -0800 (PST)
MIME-Version: 1.0
References: <20260129190444.225306-1-rkir@google.com>
 <10b26b57-bcd6-4853-9e2b-b8410b404806@linaro.org>
In-Reply-To: <10b26b57-bcd6-4853-9e2b-b8410b404806@linaro.org>
From: Roman Kiryanov <rkir@google.com>
Date: Thu, 29 Jan 2026 12:25:24 -0800
X-Gm-Features: AZwV_QgRxZxdikd13069HVFh9AeSLCghWFUHRfyeIVoOCXlRMgqgPjKT1RhApEo
Message-ID: <CAOGAQeqsvEDMy4EURsWNAmRF1ZmSfmj0+s3LzxSEw7JZVeCdTw@mail.gmail.com>
Subject: Re: [PATCH] ui/kbd-state.h: Make the header C++ compatible
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 mjt@tls.msk.ru, 
 whollins@google.com, jansene@google.com, jpcottin@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=rkir@google.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Philippe, thank you for looking into my patch.

On Thu, Jan 29, 2026 at 11:23=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 29/1/26 20:04, Roman Kiryanov wrote:
> > This patch fixes the C++ compilation error:
> >
> > ISO C++ forbids forward references to 'enum' types
> >
> > -typedef enum QKbdModifier QKbdModifier;
> > -
> > -enum QKbdModifier {
> > +typedef enum QKbdModifier {
> > -};
> > +} QKbdModifier;
>
> Yes but:
>
> $ git grep -E 'typedef enum.*;'
> include/hw/misc/auxbus.h:32:typedef enum AUXCommand AUXCommand;

I also grepped through the QEMU source code and saw other examples. I
limited this patch to ui/kbd-state.h because it is the specific header
causing C++ compilation errors in our project. I hesitated to touch
the others to keep the diff minimal and avoid changes in files we
aren't currently using.

Currently, QEMU has a mix of incompatible and compatible (e.g.
block/block-common.h, BlockZoneOp) enum definitions. I think,
everything outside the include/ directory should be implementation
details.

How would you prefer I proceed?

1) Keep this patch focused: Limit the change to kbd-state.h to fix the
active build breakage.
2) Fix public headers: I can send a v2 that fixes this pattern for all
files in include/.
3) Tree-wide cleanup: I can attempt to fix every instance found by
grep, though this touches private headers as well.

> 2/ add a CI job to ensure no more are added

Regarding CI: Since our project consumes QEMU headers in a C++
environment, we are effectively serving as a test case for this. We
are happy to continue submitting patches as we encounter these
compatibility issues.

