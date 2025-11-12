Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC776CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 08:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ6FE-0001In-W0; Wed, 12 Nov 2025 03:30:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vJ6FB-0001IG-JB
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 03:30:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vJ6F7-0000YY-Al
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 03:30:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762936212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=ij0r8Oi7E6TAFy4mLa/c9i5fRjCspdyvKwmYgBQpPNhDNfsy5m9GPjKLpUUyC9Bx11HqNE
 254MVt+upF2h4mJx1lwXHGFJreZBdo9MIi6V36vuKjtXpGBwWKyxUuS5aXUKLg8UUN3n33
 R9a5LoCfLkRwNscCqX4DRURBx4PiSTY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-Z975mQnjN_iQliGO87KjdQ-1; Wed, 12 Nov 2025 03:30:10 -0500
X-MC-Unique: Z975mQnjN_iQliGO87KjdQ-1
X-Mimecast-MFC-AGG-ID: Z975mQnjN_iQliGO87KjdQ_1762936209
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e47d14dceso2681775e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 00:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762936209; x=1763541009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=uAbmOMeufs9Tyu19s2If3vOhq94BFCHB8/hhy71k+MFOJOMnypqppHkV+83FmbqUN2
 N30jbz7z2cMKMG3Dd8oLbSVuKQWa8dCZPy5Hdzhqz0OeSweJhgGmYhM7Fp2XR0h3oNZF
 9bxGaA0cYhKHNrGSi07j2MwPTQ3XBj+yvEr5A2Gunhawby7CQLZFuAy8iGmEeKnAdPu3
 32uhg9Bfdv+5oB6wF1B2KI1KbXB11345SlhyngHkEy1UhgBKMGHc+aoY3Tc+iY5vzJRw
 euOwEyBU8U+uXARqjMk7NPAKQ7KKPufJMdvWx1xpHVO7RRAEGDc/SxzFgPlWbD5aq1E+
 dsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762936209; x=1763541009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=OWMNdFaKIYrKfnHLMNZs4fmWJz0C1b7Zu35jEsWp5G44ctXU90nOzJC8UZalT2XBue
 QCqK0gdhRQcOVC4xEIPJ5BmB7AsPSsrTW9K4hNN05pWJcyAQ8k8Whr+pYH7f30Q7eGsa
 xsTOPGP6ZUjb47Q1rcWfsiZhPi1AEYTK+l1JPqXQcnJGScyyGEelmhExTCiwgmeh88CN
 R5yk5MjmGFLiT76pOYE0UzQkeFVdOH3bkWFpfH20jvfYiw/iOVS9PVSQSeustLUd556f
 6XDUZKc5sVc65+cO5Ac8zhEau0UgVdBLEATxnHGbIXMxaqR5VknfofSxd4INTbZnrMF7
 s9hg==
X-Gm-Message-State: AOJu0Yyu5Xib6MJr335/9glMWU+4ZyQUJRDcnArLo1UdiOy09gf/zaU6
 GAgEcvqBNdy8RXtG9HhltQ9X+P92R/S8D4AXQptJTiSbuUeW8KhQx81vGUQTRt6JFxkNCexDGE4
 +nwyxysrI18jGfLv3P51pEHu2xaJzdnwtfLRomKWjKK/2buUOo2wYVC8t
X-Gm-Gg: ASbGncsDWYCUc49sLqORQHZOWQGjQnNsez6plHn6+rECZUoQGCmpCAYzPTbqrNVUGwa
 2+Edb668pHQc+QKW3L+AaG3Y/A90TOrpJ3e2W1tMRHniht7MwNT5v3Eg/o9uuFf7NpMCn+iPwH1
 02Eqi4ZgVpRoMXqVMhzNvmYjpcUNkHGO+CZ/6pffpAiYSM+05HMuKtnDPPTyoPQ3leydgxnxvW9
 LZ0Ufx3F82uu+3KtJAadMpVHYHjrQ0TduewZODs4MY8XCm0T9amcAN2sDX8TmRpKxeEiZLozE3u
 39vYnQbLzd/ND1wLmWODA6omvJBhIFlsvfC1VolWlS2mC9sF3O8GBRSDHMNb73A6aJHl9O5JEj/
 0gsc5DJftxQItb7P38esXiL0HathUXRfiX2qCruEVdoI+zHGDrH4Ld6xsK6E4fw45iNnCbL9oTS
 UKja5Oeg==
X-Received: by 2002:a05:600c:c493:b0:475:dd9a:f786 with SMTP id
 5b1f17b1804b1-477870be153mr16157685e9.40.1762936209312; 
 Wed, 12 Nov 2025 00:30:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrPkZeoCx0w6wc2L0ze4J5LK1TOLmB4zvIQ8c5Q7FNViKH1YsR+V8oMsiuQCz2fHDdhmHENg==
X-Received: by 2002:a05:600c:c493:b0:475:dd9a:f786 with SMTP id
 5b1f17b1804b1-477870be153mr16157485e9.40.1762936208969; 
 Wed, 12 Nov 2025 00:30:08 -0800 (PST)
Received: from [192.168.10.48] ([176.206.111.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e51f54sm23548525e9.8.2025.11.12.00.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 00:30:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Nicholas Mosier <nmosier@stanford.edu>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-trivial@nongnu.org
Subject: Re: [PATCH] i386/tcg/svm: fix comma operator typo
Date: Wed, 12 Nov 2025 09:30:06 +0100
Message-ID: <20251112083006.277792-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111-i386-svm-vmexit-typo-fix-v1-1-49f0414472cd@stanford.edu>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


