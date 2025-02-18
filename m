Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AEAC02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 08:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkIgE-0007NW-LR; Tue, 18 Feb 2025 03:10:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkIgD-0007M7-59
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 03:10:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkIgA-0008QB-P3
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 03:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739866205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=DrjQn4uOTP/VbEqLlRtZ3yAg5EP1lOb0Qa8rI7GGpTcwsNg63oLAsH16sgS/BA3zF+saUM
 NQLIdzEcoPhnr1v/N4xsski3TzryJ44Fdgyi0qgDPLQyqy4EOOUXCnaTOkF16atR7H8ZnS
 KvFFZOuA20tIzvpTRxeAs4t2fwmGa1Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-YAlc5I4uM1mZLhAkRmBBEA-1; Tue, 18 Feb 2025 03:10:04 -0500
X-MC-Unique: YAlc5I4uM1mZLhAkRmBBEA-1
X-Mimecast-MFC-AGG-ID: YAlc5I4uM1mZLhAkRmBBEA_1739866202
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f2726c0faso4679404f8f.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 00:10:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739866202; x=1740471002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=knoaOZwdjMjbk2Bc1J5fq1rSnBHkwSS99dnMNSCwkIgOocfejkDxAz516qr3Sxd8WN
 iFcPYiA0PM5sem4uxOPpYdYELOpfLKRRagwH01B9SyD2fxDc63qwHKfNPkezyUm+YpqZ
 JETmFYAvbu6VXvCxWIFcBrfSXxPLVK1c2S2XJ2Sl/SBuiR/U19gBgxjgSOosGtPJrKtt
 SxhRL33Xzw3hSakhavez93P+r1dXWtOpIHDmjC0fFV+fv9JHXNqLdu6FXCyCuyBJ6qhQ
 /K5R2NIWEMZxbk4SaBYiIE88toMFizKwHOfj5d3mQhQZZE0UjVLbYbLjgCDEGSO18Jy9
 CH0w==
X-Gm-Message-State: AOJu0YxnrpkeVOuaGJoCfvTA0gNujRxrBEJ1y501kmClearTGkf3FW14
 FO2/0fo3XL5IZrvuHCYyS0dN9vJ8G6d8Fyu9vuOefyKCryq5cuwdNKmjdeERU0AfZG7tc841x5D
 PZBCA6SKxPL/WuyuUoFEZ6so1VMIyHGCpasloKizGU87BNh2tAXqy
X-Gm-Gg: ASbGncu8gZLR1M6W/Y4lKMMsa8p88EXe8JDb62nKFrXuYRL3qd60xTsug6nhMWKqZef
 zDjD8u8oRUNqH1+cGjZy9D9SmX19p5NcCPM00lfn4UNfifrXaPsgz16eKvIB13iczffWM177a1m
 3feRJSItMCoYUwQoPLLFCQl3sDqub3SrVK/vBqV+XraZ5btU/jnzdGrFALDJcqMhkgX0e1L74fJ
 pHOxAkVZjmcWnkckzneyzTd9F7POfisX2nyy7BJ/gY1GVudt6RbN6j2UnbAPD7d+IePsPKwW0Vb
 ayUY5JY619I=
X-Received: by 2002:a5d:50cd:0:b0:38c:5e03:5bb with SMTP id
 ffacd0b85a97d-38f33f51191mr11134009f8f.41.1739866202362; 
 Tue, 18 Feb 2025 00:10:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdHkGsLvx5BB0pMui/Y6m3zGmUy9i8EvLutO1qkUbx1cmyFKEXR4C0wf+mtetYDNqJCVssmg==
X-Received: by 2002:a5d:50cd:0:b0:38c:5e03:5bb with SMTP id
 ffacd0b85a97d-38f33f51191mr11133966f8f.41.1739866202031; 
 Tue, 18 Feb 2025 00:10:02 -0800 (PST)
Received: from [192.168.10.48] ([176.206.122.109])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258f5efdsm14101840f8f.43.2025.02.18.00.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 00:10:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org,
	qemu-rust@nongnu.org
Subject: Re: [PATCH] rust: Prefer std::ptr over core::ptr
Date: Tue, 18 Feb 2025 09:09:59 +0100
Message-ID: <20250218080959.430745-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218080835.3341082-1-zhao1.liu@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Queued, thanks.

Paolo


