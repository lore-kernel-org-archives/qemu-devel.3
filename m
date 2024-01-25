Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2847C48260
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 10:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSwWB-0007Yu-3s; Thu, 25 Jan 2024 04:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rSwW9-0007Yi-IX
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 04:59:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rSwW8-00064B-4W
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 04:59:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706176766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=PlSS/pEgKTA+QfCZu+4ZTB6enIuFFOy+Bhj4fWYTogXBQvu9XY9aHD8CHVaJ7mEZeowXEQ
 8TOPnPdwDimuMH5AIch+/76hBFxE8C83phVfrejJOPR1OoCa/QXc9OEyd5krfftFnH4Cwu
 vXRDbL4cVhx5SXaRNWuBGLBN7yOPRHs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-aJ_p-zfTOpaYrCk9fJDlMA-1; Thu, 25 Jan 2024 04:59:24 -0500
X-MC-Unique: aJ_p-zfTOpaYrCk9fJDlMA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-50e5aa11579so269194e87.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 01:59:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706176762; x=1706781562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=bmBNECS83CwDKeavQlCjVMi5rMMFz8FKiHCRmYIsQuJnspLF3InIZo0fznUduDoPLY
 w3Iv0o5lFCZSix+gbg1ukuzGqX24fFsa5jtATtz/1kGDUw5Vi2+BfraX3TuJp62QuaKB
 YASjGMhXcpFGOW2qBKxDYNV6fk/ZpAtUD0iXJ/mfLNyBEq8ggq9Akh65ys72cs6K11AT
 BG7mYgRQ13SlJ/hHtfovO1RIOR+gnXy/04pInj3rA9tfv+i6uGimuziqvi1aRPjO0TAj
 DLXbw62jXeUHcxbfSfjo5nprt8syx+2tGxnqhGICRmHUlixKrb583VVsIrHGyvUKXUEy
 VdUw==
X-Gm-Message-State: AOJu0YxG0bUSRzn2FT2+yyCNnPfOTm3s1e9g1Q9hyuI4bXKZAbMvWUwN
 qUYILBkMdNKdH9JhCVXesM3MuLfFWCXvMkfTM91Z74JWH7wuXGHo87uipCwAs2h6xCtO+cP9DsM
 jxhNMDdZ0n7Q5QFqqlkDDZN7yWvCh9d+f26aepGAOPkHKo3zYO+EG
X-Received: by 2002:a19:6758:0:b0:50e:6c1d:5dee with SMTP id
 e24-20020a196758000000b0050e6c1d5deemr366000lfj.33.1706176762524; 
 Thu, 25 Jan 2024 01:59:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4VVeqiCEvMmBC2tqEQ9bv69Y8qmj0jtr+6y/dyvPmZviNDquh+b2NbCAnkXk9F3RgPSjubw==
X-Received: by 2002:a19:6758:0:b0:50e:6c1d:5dee with SMTP id
 e24-20020a196758000000b0050e6c1d5deemr365993lfj.33.1706176762164; 
 Thu, 25 Jan 2024 01:59:22 -0800 (PST)
Received: from [192.168.1.174] ([151.48.72.171])
 by smtp.gmail.com with ESMTPSA id
 o17-20020a05651205d100b005100581ad6esm744899lfo.160.2024.01.25.01.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 01:59:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org,
	Yang Weijiang <weijiang.yang@intel.com>
Subject: Re: [PATCH 0/2] i386/cpu: Two minor fixes for
 x86_cpu_enable_xsave_components()
Date: Thu, 25 Jan 2024 10:59:18 +0100
Message-ID: <20240125095918.781053-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115091325.1904229-1-xiaoyao.li@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


