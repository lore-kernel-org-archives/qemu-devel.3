Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B009C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbNZE-0004jw-D1; Fri, 24 Jan 2025 12:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbNZ0-0004im-PU
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:33:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbNYz-0000yP-El
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737740027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=LHJlhEWherXHIVubmRtB0nV/BnkZPYyEExQ1GOzTbj+x2ZvUMGQts9j4nCWfBphPGt22oR
 2XeW3ftJi9gyPB07kG9pd0tTe0XCdWfPb+9T5bJPxGJd8fuhc+s3gpZ3AD01mG1xiLgcLB
 KvFddCiSRcUl35LWcoRytHcryYb/Zk8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-mJZYbWEiM1yNiWto79s4Nw-1; Fri, 24 Jan 2025 12:22:44 -0500
X-MC-Unique: mJZYbWEiM1yNiWto79s4Nw-1
X-Mimecast-MFC-AGG-ID: mJZYbWEiM1yNiWto79s4Nw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3862be3bfc9so1279261f8f.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 09:22:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737739348; x=1738344148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=ZKyU3CtVnFMcsWpMCZAV46Ip9PLeIz5hbqK20xnmt9heoON9hbXDa+iJPKaFcMjiMu
 OdWjNNtzLdVoNEVI3emk1YzO1/+ZMIJVFSDvQ2cx22UJ6OO6gHzKwlHv7zAuLHjjIKiX
 p3Gje9Q+ro3hqJ2kfSRO0nR0Zt/y6hMrrcs7RPXePvPqhKEl0BPVXU2eEgBOSB1Y7Xbh
 m7+GG2AzCkHS5QrfE8UfNEoQ48Jk/IoqzaYzS75l+tTNLli0rZSVUb5uFv+ufm97gU/B
 919t2zTKc0qGtQclNcYsRrfeVVzszcnsSd1/JPmdIyxdhMS/KtsHbiadKtdY5mejUo2S
 bA4Q==
X-Gm-Message-State: AOJu0YyAQyFJH0pExSv89fl/uKJj+apxC05+tH8sfBQV3C3sx4osLfad
 zIOXsYvqAA5o+xZmKcOIiQiaM0mHMLSEYBaf4aFS/wxgB9FJjei/x2obMl0EoPrcURZ1+swMrbt
 qccF2aNTYamtMUOKoS1rT9ovkEW7F9dXRL5lkMSMLd8WgUIYn6SRh
X-Gm-Gg: ASbGncvR5pyOlqVrmGJhViWe4IwyYRxlBdfZ1YQgr/4q17xT0KSaifBBdatLBP9k9Ak
 O8HK6vMC0gTAJW2lTdNSBqkoQA/cQt0t34LwNy3dC/5bWWyGpDd3FXYkjwY5R1ewfNl1BrgVtjI
 dpoQ4pC5iK/QJE/Q1PkNKild9tEdhGjYP894LpriikXsx+PngLCQjegQkjdtimsAZoUd7XuV4E9
 /pl9ZBAq/LEYanksIgjiPU6+9CBx50ZAcacU0XtT8gZTKB0JwMpQrz4PFFQJ4+e1arYvA4M4Q==
X-Received: by 2002:a5d:6c66:0:b0:385:fae2:f443 with SMTP id
 ffacd0b85a97d-38bf57a91a1mr26883935f8f.34.1737739347851; 
 Fri, 24 Jan 2025 09:22:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzrBPwFiXCQ9qNLHq0qMBhuPE5qzQz241IzIA6Kz4r1j8E5FENm6+ZtwFZb027b2Tyk92ZAA==
X-Received: by 2002:a5d:6c66:0:b0:385:fae2:f443 with SMTP id
 ffacd0b85a97d-38bf57a91a1mr26883923f8f.34.1737739347577; 
 Fri, 24 Jan 2025 09:22:27 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd501f1esm33349735e9.12.2025.01.24.09.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 09:22:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 0/2] target/i386: Fix 0 * Inf + QNaN regression
Date: Fri, 24 Jan 2025 18:22:24 +0100
Message-ID: <20250124172224.815473-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250116112536.4117889-1-peter.maydell@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


