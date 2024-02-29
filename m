Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53909C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 04:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfXmw-00049o-TY; Wed, 28 Feb 2024 23:12:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfXmu-00048d-5L
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 23:12:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfXmp-0004x3-Ib
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 23:12:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709179966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Z6OK+/4/QIFZ323aMBfsrxIYJbrBPSqXaTavp15XRo=;
 b=crz5T0NrWS8kLHGOuIomsbVhyZRx+QeYhW5Iwe9ecaNLvf6UT+IEdQvmPrJLCwXmbxFWsn
 +sEwHK+DUVEbpf1q70jC04u2EJEuk1nY3mGJMHrWvHRPKJuenzwapinxzd/INFFqE0NIQO
 NptspYDj0ZRHZnGfUb2HZCXAqM5EhuI=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-ytZ_pnUoMBmc15R0U5tALg-1; Wed, 28 Feb 2024 23:12:44 -0500
X-MC-Unique: ytZ_pnUoMBmc15R0U5tALg-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6dbd919aba8so155976b3a.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 20:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709179963; x=1709784763;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Z6OK+/4/QIFZ323aMBfsrxIYJbrBPSqXaTavp15XRo=;
 b=EDYLitfns6RIzvOhhKJdRki8H1XYAydZ5w0YAcpjB93XbsRz8zbCHj0nZqAH0FCNo7
 gmfKiEbdhyx2ftLULWOkk7iL3UvFEUNRYSm0hTT0liA1HOiuqDuVXN7nZs8kQEADfZOO
 640YN5agGrBkhPvN3fs08Wy61LUx1Tpfyv6VvOb+YCYwujttgNx0FIr3wtHLdhsCS/uu
 +UiDdIjhk3+kFCNGdGMJ2zfSO61OqI2Pxuyo8c7c4Qo60FoxGfj7ZWVUX21ZhhD5PYhS
 guBW2zoC17yJRMEysJSpov75km90S1Q6o7pAHovKYUyWzDw7HyzRq0z6blUoogOF2qEo
 QV9A==
X-Gm-Message-State: AOJu0Yw6Admcn16T0AYXK77GDAbx52CkXM/NaL6vJfXEtJFW7ksTUC6U
 6hbPQWm1cGrfbuLjTbUj0tDMJm6lpSCr/wm58a2S4fOT3yyRq0xntkWAPs38+k6y1NLCyJbfV+Y
 i0O3hpfd/CfjZgsTI8x1auQGYvZxaVg9rFnzxo8++2bGaIwGLbmGF
X-Received: by 2002:aa7:989a:0:b0:6e5:53b4:8c19 with SMTP id
 r26-20020aa7989a000000b006e553b48c19mr1172514pfl.3.1709179963627; 
 Wed, 28 Feb 2024 20:12:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECQdWO0Ry/zB62XoOYQFgrj9G8i4875QqiSvuUEn3JTNLGtKIpBccFMkQhDwi5ZeEcUMZfUw==
X-Received: by 2002:aa7:989a:0:b0:6e5:53b4:8c19 with SMTP id
 r26-20020aa7989a000000b006e553b48c19mr1172504pfl.3.1709179963298; 
 Wed, 28 Feb 2024 20:12:43 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 ln21-20020a056a003cd500b006e363ca24dcsm233074pfb.67.2024.02.28.20.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 20:12:42 -0800 (PST)
Date: Thu, 29 Feb 2024 12:12:35 +0800
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 04/21] migration: Do not call PRECOPY_NOTIFY_SETUP
 notifiers in case of error
Message-ID: <ZeAEMyoUeqsJ2RC1@x1n>
References: <20240227180345.548960-1-clg@redhat.com>
 <20240227180345.548960-5-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227180345.548960-5-clg@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 27, 2024 at 07:03:28PM +0100, Cédric Le Goater wrote:
> When commit bd2270608fa0 ("migration/ram.c: add a notifier chain for
> precopy") added PRECOPY_NOTIFY_SETUP notifiers at the end of
> qemu_savevm_state_setup(), it didn't take into account a possible
> error in the loop calling vmstate_save() or .save_setup() handlers.
> 
> Check ret value before calling the notifiers.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


