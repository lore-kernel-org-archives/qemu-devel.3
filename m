Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398D9CAC587
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 04:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxHwb-00032f-Cr; Sat, 13 Sep 2025 00:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxHwZ-00032S-VF
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 00:32:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxHwY-00032P-AQ
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 00:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757737976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=X9sNmUGgg+flCbsx4P9yhTTRKRe4/5xTK9VPwlyhc/xXV5Vm+aU2bUMUG/+2fqGJnEXLJy
 OzyBgXTsC1vgvm5Gtuf+KqqwhdKiGIVo483AZqcRQdivdytDzAfqUoCcei4Meuo07TXpH8
 zEwmJPpIvLtPmw8thADP1tuQjNNp4w8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-OCEYOjB-MHSMxAPInwfgCg-1; Sat, 13 Sep 2025 00:32:55 -0400
X-MC-Unique: OCEYOjB-MHSMxAPInwfgCg-1
X-Mimecast-MFC-AGG-ID: OCEYOjB-MHSMxAPInwfgCg_1757737974
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3e1e7752208so1457410f8f.3
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 21:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757737974; x=1758342774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Lg2JyK5Yi+E0nVKzWGSH/raKt88FJPhc1anrHaSYpt7Yew77npnW0HHDZgl9z6iJGj
 LNsWgeXTZIRA+jpi/Nccx206IM1n/fK15efdtwSrac0oHr7jtqF+q2eHG1/610FiSH4O
 zOKPBVbcDEiu0wfa3WyTaaCbPUu3k92vqiL2BXr8r30oTXN9qEOyQoin8EP832JjbB4r
 P1gX1ds/YWqTu3ABE7gC/91F1GDWKD751rFuNryzs8U0Nhff46+HG8dDSg4YJNVa7kBN
 fXUxtrBLPW/uMwBhkTKmZScmtHAjwRmm5T6VbT7KgApI4Cmj2Oy5w4QR6AkT5shbP+YG
 FhtA==
X-Gm-Message-State: AOJu0YxR6JULOHBnzsa0/j640f/P6B0Op1jZeUc6+oqtVzxQEP6Hrg96
 fNdQWkc67xCyRSlDeN6qhDKho8LHen/W7OnZGROGyWaSWMVuqULANkFI8xGClP03a3mG/q9HwFv
 pfVZrSske3mDQSMcaHlD4jMyrr0qbCJr5Aw0et57Q+gelCNpba7L8r00J
X-Gm-Gg: ASbGnct37xFVuT3V7SThj/fJ+DEyLV+cZY50xQxz6vfhh8ABmxpuoSVEIRo+T8Yp8DA
 KN15cM6q1SM9cu8TRXrdwEThRRZ/XER5rNmu+ZeHrpi0f41LhL1wpjGkPqpyLsh1VNJL42e21bB
 oNZx2aMRK91xD8Utxntb1bx3NfYuSioP99fa13EBcapefK9LI5ERdzKpE0rxL7KvJxCue0BaIsR
 Du0eqGmdT/G5x8VxY5oC2X1Cd4tqpiReGzh4wviOO/YCuQvTBY/JIr2jMsLdGEj9EiTA8Tx6LJi
 InFWGnxYG84yo98RtmFhatTnB1MKQlrOMo1+zkPbaAvmZJadJVGKf1U40uxxgw5Ks+BNNJoIYjk
 bui+eW87RRTxYcBFSUBbDJcISpl7I/cPMwvmbqX0Zu5I=
X-Received: by 2002:a05:6000:2c04:b0:3d7:cd09:ae1e with SMTP id
 ffacd0b85a97d-3e7657975f2mr5134449f8f.17.1757737973964; 
 Fri, 12 Sep 2025 21:32:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvYJdG7+85Cg01fHVozWMeGN0qpd9jxSWfA4UmON1VFLOalUlNtwOgzXJe6TZn3SYe85bcyQ==
X-Received: by 2002:a05:6000:2c04:b0:3d7:cd09:ae1e with SMTP id
 ffacd0b85a97d-3e7657975f2mr5134436f8f.17.1757737973580; 
 Fri, 12 Sep 2025 21:32:53 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm8970951f8f.2.2025.09.12.21.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 21:32:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org,
	Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH] multiboot: Fix the split lock
Date: Sat, 13 Sep 2025 06:32:52 +0200
Message-ID: <20250913043252.2549310-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250808035027.2194673-1-xiaoyao.li@intel.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


