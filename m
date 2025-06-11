Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE849C61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 13:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPLEN-00050G-Cw; Wed, 11 Jun 2025 09:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPLEM-0004yY-0x
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 09:11:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPLEK-00065C-6Q
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 09:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749647456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kB6yIVfO2HF0upfAAXtnXlTUS3vFMabCNfe03UnjCzo=;
 b=VVnKLDAOKxCl4GlZDlIKYQ6NH18VESvv4Q53OeHnLbZ8gUA9PwLov5rbtWgoldxbg951Sz
 uvBqmQGyuJr73Tye9tc8hXUAqoLVqs/1N91jizf8Ykc671vMd9rhkKLfTFKkH2WDmMQTHH
 LaJF7chUjAfkgT/sT9Z+y9K/gZWo7LQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-SZ-XCoNVM-y9ldPiRLCdmQ-1; Wed, 11 Jun 2025 09:10:55 -0400
X-MC-Unique: SZ-XCoNVM-y9ldPiRLCdmQ-1
X-Mimecast-MFC-AGG-ID: SZ-XCoNVM-y9ldPiRLCdmQ_1749647454
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-453080e4741so32119495e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 06:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749647454; x=1750252254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kB6yIVfO2HF0upfAAXtnXlTUS3vFMabCNfe03UnjCzo=;
 b=U1SDIblwe5belUNFQn4qfck+3zA4P0sOq1xPYbiJKkKxT4nVm5cSCTPazqFZvovJaH
 cXVnRncABRDcuCNc40OjYIlMaSdiRANbwOcH7QWG8V++OvjFWyE+ymauJtXEOPMBcDXR
 Ki6fKlJRpIUghFQNY9E1SzkJEbIMFDLuTwD/h/zxnJcMNfloEwhbwv1wSYQSg0oQX0EK
 DRDbTXrxyLx3YT7o4d9BNh9ZCnhakmLDBuHagvbnrbYVUe1be+b6+0rkx6sGZa0N2VKO
 RY+OXdAcywL8mZKoevy7T/kUZs8fReiA7QwZDnsADrWk5duEfayIsBChG/Wln4Tk2zte
 6ovQ==
X-Gm-Message-State: AOJu0YwMIsW/IzMbPcSw00zFJjXXbno/I+6r/gkxxcA7SDYFPpsAgzD2
 vLMW4EeTVX+L1zIRBxMleg6R0o+9pgQ4ijkR6AWdpPFckTKhsOPqPXBOcCzFaX65NQT79v95zzd
 I4NUawZo1KYGbu4+tdkYLrQsrYVczjP6VB9rB3u68QDajS0Es7luJBooA
X-Gm-Gg: ASbGncsif94d1DbNJxT7VZbM4ZqExM6on+GSeXlxS7dmaK0zObCP0N+xE843mfEEXBU
 Y5HXkLdljcYK7yC9LrK3+LAMQn4KKQkXkHVHkATjqFOcR+9Tr9YVyuP7kC+18uKyM6kG0P7FA0p
 cS/5uydpO5UWe1YY6GoFEYAAAVkJiJvrkl44kfwNxAewEJgAjkAHjdOPShVqPtUvWeCR9UAi7Gq
 Fl46IE9DK/oeZKi9SWZs0/sspE2FqJ9NvFuIlp+FapPEcsBAI1RRx7RbNsuX4M3jyaob3Oo+/XN
 wg+rdCGQF0y97hpKfd+S58zd
X-Received: by 2002:a05:600c:3511:b0:441:b19c:96fe with SMTP id
 5b1f17b1804b1-45324882d3amr35222035e9.10.1749647454335; 
 Wed, 11 Jun 2025 06:10:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp2ix5BspRb47dluGnZUln3CEoyn20/BBSt8BN7U+T7boGjFz3KnJFqJgtEhdSNzPisIik1g==
X-Received: by 2002:a05:600c:3511:b0:441:b19c:96fe with SMTP id
 5b1f17b1804b1-45324882d3amr35221585e9.10.1749647453978; 
 Wed, 11 Jun 2025 06:10:53 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5323b59d0sm15416717f8f.38.2025.06.11.06.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 06:10:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, qemu-stable@nongnu.org
Subject: Re: [PATCH] target/i386: fix TB exit logic in gen_movl_seg() when
 writing to SS
Date: Wed, 11 Jun 2025 15:10:31 +0200
Message-ID: <20250611131030.971554-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611130315.383151-1-mark.cave-ayland@ilande.co.uk>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

> Before commit e54ef98c8a ("target/i386: do not trigger IRQ shadow for LSS"), any
> write to SS in gen_movl_seg() would cause a TB exit. The changes introduced by
> this commit were intended to restrict the DISAS_EOB_INHIBIT_IRQ exit to the case
> where inhibit_irq is true, but missed that a DISAS_EOB_NEXT exit can still be
> required when writing to SS and inhibit_irq is false.

Sorry about that.  Queued the fix, thanks.

Paolo


