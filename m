Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7C1C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 13:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsMDr-0000AH-Up; Wed, 12 Mar 2025 09:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1tsMDo-00008g-1k
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 09:34:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1tsMDm-0003j2-0P
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 09:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741786442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3CJd/CSTCPvnYuIC3x6clQuoYz2CXg77OwHNpnx5j1M=;
 b=O8JQN1KZwLMJpwfUNeNLYwYlwFfHNv6V69ah40oiterCPV4bg5FnwEwitW0W3pj7UUN3mX
 5Tc2LYixfGn+lhCyc3FDqwIGpz6M68oQTZAOSGqeHZvBGDGD/omhUk+4+MNxeTPeevQkH0
 SbvBkkCkyDoj0y2M6/fmG9By8vZT4F0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-dtqmuglcOfm6NkfNAj3W9Q-1; Wed, 12 Mar 2025 09:33:53 -0400
X-MC-Unique: dtqmuglcOfm6NkfNAj3W9Q-1
X-Mimecast-MFC-AGG-ID: dtqmuglcOfm6NkfNAj3W9Q_1741786431
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3912e4e2033so3453670f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 06:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741786431; x=1742391231;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3CJd/CSTCPvnYuIC3x6clQuoYz2CXg77OwHNpnx5j1M=;
 b=KjHAZsRTaZ/w2wau4+8H8drGoT2mY/33+GGnZYuEYPid5cfU0B6PnPklO8Ur96x2BN
 2Iac+rGt0lTa98khTVaEgBn9xN/AmKLQJtaEp28k7e2UUQ5MppOtrRdDIKJeNUp+9oUK
 yS+qWUtH/YNnrC2hUr6/gR9Ify75EJL7/9KR5j01/LH/aoWA+rs9XRah4VaPHNhzL/5j
 wXxbHgEZpC1XCRJNMsSGer2so8O7jVM9sy9CwXIPH6ZmOj+HPmS4HMOVIct0vpfm4SQx
 wn6PPZSQ9Zg30h1pYENZwAM1RZ2KaXz+xx8xX9SFsRvyXCr4mn5Ap8CoDVGXferKg+UU
 SzVQ==
X-Gm-Message-State: AOJu0YxLg0eSGfVzts4zkcSNIUSwol1WoNQo2nz3FRhxB2ss4LsDPw1f
 moZnnSGaUpVqp/Jce0s7Pf74gQPRXApEXGnZuYHZ4A+bnP6Uqrx3XjrRG8s5dbhTtM6p4/1+bhE
 JsXUqGf2hFNB0UGdhRceFvQEoH34we/aZGoFB5gZdR85L26FLyiBE
X-Gm-Gg: ASbGncuJg2qLLfDZY7YRBk6ykPN/k4+hNKSeSUKPwNIomMWeIHKbwD54ysAHQT5KIaU
 XmtZOfxtVUmKgF/lv4c1EvpRZLkNxAzANZL7fj2y3KcuYE4gLDN199KOF5IOodb17QY9uFJTkG7
 TWYeMsv+oLCpaJbCp5/7DKA0YPOKwtdPu8K1NM/o4pd2fArmr5O3Bk0gcs1aJwj8vNooxCKFWUw
 msLL1uR/E5RjgxquYAdgmmUUqyzi5H/yZf9ICmfTHxFVwjOUnhUEfXq9XisM3cJGEo52CD+otTu
 t/zL9IA+kP1gtvfPv8jILi6RZoJRdsLtAU3tqmzY+rrm
X-Received: by 2002:a05:6000:18ae:b0:390:f394:6271 with SMTP id
 ffacd0b85a97d-39132da96b3mr19956416f8f.43.1741786431098; 
 Wed, 12 Mar 2025 06:33:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiH0yh2DAByu1eso5HoOZBimlzb/mcjmQRHz31QfqeUneh/h08yZW40BbOu7lY426p1BPISA==
X-Received: by 2002:a05:6000:18ae:b0:390:f394:6271 with SMTP id
 ffacd0b85a97d-39132da96b3mr19956401f8f.43.1741786430756; 
 Wed, 12 Mar 2025 06:33:50 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3947a24449bsm1765487f8f.45.2025.03.12.06.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 06:33:50 -0700 (PDT)
Date: Wed, 12 Mar 2025 14:33:46 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth
 <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus
 Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2] docs: Explain how to use passt
Message-ID: <20250312143346.799b24a5@elisabeth>
In-Reply-To: <20250311132714.166189-1-lvivier@redhat.com>
References: <20250311132714.166189-1-lvivier@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sbrivio@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 11 Mar 2025 14:27:14 +0100
Laurent Vivier <lvivier@redhat.com> wrote:

> Add a chapter to explain how to use passt(1) instead of '-net user'.
> passt(1) can be connected to QEMU using UNIX socket or vhost-user.
> With vhost-user, migration of the VM is allowed and internal state of
> passt(1) is transfered from one side to the other
> 
> Bug: https://gitlab.com/qemu-project/qemu/-/issues/2827
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano


