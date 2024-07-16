Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF23BC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 08:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTdsW-0002en-6P; Tue, 16 Jul 2024 04:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTdsT-0002TM-4P
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:49:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTdsO-0006ar-IP
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721119775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=XUUKcnbWyG4pI4+LkxehZaViZFKpMgpgeV6B2zBzOvtB7qRuQGjYaNsXK+8pgs8XpFdvbu
 SBvKCjMCowgndHRqVa31Glvr3XxiFFEJQZL16OZjxxenWx4gjjV37c9IAbCZ+5COCLa6IL
 elQy3U0iBmn6+L+eHZCI3f7VB6D/+D4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-oCTLmRTdOz-6MgXUjMihKg-1; Tue, 16 Jul 2024 04:49:34 -0400
X-MC-Unique: oCTLmRTdOz-6MgXUjMihKg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-367962f0cb0so3695188f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 01:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721119773; x=1721724573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=nkEQ+6dxF7bmUfjOt0QmOIeaPRzOE8UGt2FgPUDjlsHh4zdtcbYYBKPMDKYcQPAcwy
 q9FsiIwjGg0TwFfenYTbU6AatDSAIxj8LL0gmZ5SAjcoZex33lOj0ZK2SlqNN7S/EnV0
 w6BQMON1nMU50T+Geb9WA8h5ZsMcl2Rr4DAhdmoJrbmPWdj58D8wp9v4RMkyW6CKGZib
 dME/uGEhf2vFt+Rd88tnY+C224qp94LID4U4xw45o2u29kU3bbwlizlWxd5rGr29t1Ub
 sqUIp+7fQu55IFC/Kgs30lYDRUoa5T+adn1AJ5XCWqxuevyvrN15DfkxjEOieypzrCbm
 Gz1A==
X-Gm-Message-State: AOJu0YyXjbTt7pH4ivLFPY1A/HRSkBcwAuCTr/rqO7awF3kQtmSbKqoM
 W521ijmD/Zj8Mu8Ep2CW1ZDLne47A2EXQ1fp1WNYv+7T3MjQHLcVyIQzREveFY95CHZV8QKBl4E
 Fmyw9+nUAPNltnkoRrREO7PGuabGT9mIw9+3nsmJQq49Zoovttjc2
X-Received: by 2002:a5d:60d1:0:b0:367:8a20:b1be with SMTP id
 ffacd0b85a97d-3682613c933mr801442f8f.35.1721119773451; 
 Tue, 16 Jul 2024 01:49:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFINwytKwvwF24R4/b6BiD0keJ+7BHGLjgcT8t7FaHl0sHWAacvSnbVoY3e/dPr0lI5rjTCjw==
X-Received: by 2002:a5d:60d1:0:b0:367:8a20:b1be with SMTP id
 ffacd0b85a97d-3682613c933mr801424f8f.35.1721119773096; 
 Tue, 16 Jul 2024 01:49:33 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680db0ee46sm8285717f8f.114.2024.07.16.01.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 01:49:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, fam@euphon.net,
 pbonzini@redhat.com, svens@stackframe.org, peter.maydell@linaro.org
Subject: Re: [PATCH] hw/scsi/lsi53c895a: bump instruction limit in scripts
 processing to fix regression
Date: Tue, 16 Jul 2024 10:49:16 +0200
Message-ID: <20240716084916.185592-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240715131403.223239-1-f.ebner@proxmox.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


