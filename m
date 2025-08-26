Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4C5CA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 14:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uquwA-0002xP-G2; Tue, 26 Aug 2025 10:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uquw8-0002w7-5o
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:46:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uquw0-0007FY-54
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756219558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=RE+VZhDlRtJVXVZ2W0QTezr3kbki9RC7PcuFZ+sTOtG7bkITjDwvW0tzxLrsRp7BsExUKc
 hBs3eA8CQIJIfSMIXumZrRNH0kendPn+GoGneRXzPqUuLxm608xis1DbmQog7mvT+kEXSS
 NMPvULMJE0uUvjXRigKtl1QzVOwPFC0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-a3fN78A9OrSWLeaK3ptKgQ-1; Tue, 26 Aug 2025 10:45:55 -0400
X-MC-Unique: a3fN78A9OrSWLeaK3ptKgQ-1
X-Mimecast-MFC-AGG-ID: a3fN78A9OrSWLeaK3ptKgQ_1756219555
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3c79f0a6050so1413131f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 07:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756219554; x=1756824354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=qidgmOgM3rkFqugtkdJfupikwBFx3R9QiwT3Q1Br0Iyqt45SfKPQ1wjGDpeP3tk9Kj
 WJ+nbfOoEeSryU1pn2UQiMbSWC/L5hwimtP1efXjRQ2KEkDkgIpwDU+c8FP612261M5L
 20PIsPGNlrGN098tyz4uPbAArbzdlshO4rm5aV2VbBtIsT40VtqII16X6D1Q8kU9oNiC
 1mZXtjlBESuTYe/utvHobyHHlDiIka+cEfD5it6r1yQ0Q/YrvW1XrspZAnoUkTs3XZaD
 wuLpWfL7x0S9jMLEPdoQIBRtO116mEp6z15ZI6yWpg6/uMlxkjkaPXJHBaVCmzzT4emr
 IhYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX17K/1s//8Iu4m6glHtYwQpf2BLnXeMurnD+dMBbGkRT8yvJBssKokG7GrZe64qjZihWpG94EBk/P9@nongnu.org
X-Gm-Message-State: AOJu0Yw4MaUKc7KrgMAo0466hbhzgyXd1VHyZDnXbDmm7kQDF4opVY9j
 NNjWSsyi4TtHSzQLjovUs1vFNftlLwxEykx5K1eAxmAKvav4dz/wlBLqwXd3Gxuc28c1avcp2HR
 /pd5MG3rqZgryaQSAtvDA16FR52thDfh3zwCkh7tzAcDJ2TezFudv3HHi
X-Gm-Gg: ASbGncuGcINIKuICvxQNE/xuL/S9rjppnhOH82Vxq3tT6FEepvwPv7zYtyFmNEM1B3e
 M+G+9bBfgUL4txPX00vQ169SvHlKdl7GXw5YsuvlVVMwuv3sow6LdsXwDoqTzRRBtBmP8TtCG5f
 ZCZCPgnnARDwManjzUmVia93De7KtrC+cWdqQ4zPJzjBb2IkSaB741CX4KHQvnaIl2n5idOK0yu
 ITEk16z1xtgCcBsMYnLROneZp1vkA65vVQnVDKJoA4KkkgkxENjIjIlXoGhRmv2g5y4elM+qWM+
 DJeKOKQhnlJgb4HmGxl4Oh4iA4OEzOx9VcYwd0WoJCCT9uDXn8noYdrZbZEWWpNVPuLB6ceqWcQ
 W/ALQ+FdAAWR4m/6AGpq858Ic
X-Received: by 2002:a05:6000:2dc5:b0:3ca:83e2:6339 with SMTP id
 ffacd0b85a97d-3ca83e26928mr4110282f8f.49.1756219554609; 
 Tue, 26 Aug 2025 07:45:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0GwVFw/WWL+tC25zVvljNEPyYp1Lg4PacyHJxgzmxoNUeYLiDxItEKF2kvv8lM7QXT/H2Ag==
X-Received: by 2002:a05:6000:2dc5:b0:3ca:83e2:6339 with SMTP id
 ffacd0b85a97d-3ca83e26928mr4110262f8f.49.1756219554240; 
 Tue, 26 Aug 2025 07:45:54 -0700 (PDT)
Received: from [192.168.178.61] ([151.36.40.144])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ca6240b4f9sm7193834f8f.15.2025.08.26.07.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 07:45:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: richard.henderson@linaro.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] kvm/kvm-all: make kvm_park/unpark_vcpu local to
 kvm-all.c
Date: Tue, 26 Aug 2025 16:45:50 +0200
Message-ID: <20250826144550.556967-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250815065445.8978-1-anisinha@redhat.com>
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
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


