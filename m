Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C03ACCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 07:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCC1u-0005yF-Lu; Fri, 24 Oct 2025 03:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vCC1t-0005xz-EP
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 03:16:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vCC1p-00014L-LY
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 03:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761290158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=LwY0CZyjTPV3LGOEdfpo91frV8S+3G4HeBfgmsZkQCATdQZFE5a+AE+c5uz/zjAIOs4oVm
 TLtxtsYQcVJnT6UmnIIfAFUo0U2D4T7w89ugvhdFK0040zGWebdBkDTYd/fHzMGlZCgsBB
 pRGU7oEXg6v02HT1w4fmKefv6GwBsZs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-yrnUKSoQMcedQKK2yjfT1g-1; Fri, 24 Oct 2025 03:15:54 -0400
X-MC-Unique: yrnUKSoQMcedQKK2yjfT1g-1
X-Mimecast-MFC-AGG-ID: yrnUKSoQMcedQKK2yjfT1g_1761290153
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3f384f10762so832050f8f.3
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 00:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761290153; x=1761894953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=w4P6/4DaRmVRLXsXBuWiDFCHAQq/R2YRYPNgCOP+hXI1IYihA+pLpZ/1S0o1iN9txO
 YgXSo4Hko9LNfr9hCzG8gpHR8KRyoyL2HGbWOQthpzEGX5yzaJ9ZB2ZxSwancGIk6iWU
 OgU89q6qhrSLlKhgqJQzsLBHCfLiF1A+ImALimu7kUqwmLLSzF42mKOEyb3ihhm/TbfO
 aXPtc7KxjprWfo9EPG6y+cHMOB437STOL6nbgJ0sVWUbTnU2BfeJmOByuAQhNTQjkb0e
 1xKKL6HlIAsK3Chs1v87CgSI9p2NE3nrlhz3P2ujj++STFFueIkTNY1McF8G7D6hR5qf
 RIMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoGWdPnK+iMARvF0/S+UXaWT9S6uPHpSVI40kx/g9QKlWDrFwV+l8izOaeP/2sPqMC4nWwz5IEtPXF@nongnu.org
X-Gm-Message-State: AOJu0YwMBEc3GFaTEwqhrBWYJUnC65Rc5b8zjF/gD2w7gzVXDEQhF5Sv
 oj3E0b0HDIn8M+lv3vUFUfJLKwxF5JwCVUEVlmhAPHzhiR0+9NhEErmF0SpnifTD6glFtnkjYc3
 OsC2hVQjR9zWt5Z77MlPC8SzrXLXDrMWV5Zido1jJyILZRMUjDk7n7Lni
X-Gm-Gg: ASbGncsLmtLcb6xt2/jSWs1VXrdFYzmX5sFu25kG7iNDi4aCTUJNUHnDFZfP8+8dkGP
 MBS6NQFKHoYGds+WxlqKmO293otPMBB1DS4UtVZyVOCISJQidxBLymKJYRtkchv0sZqKThWD9V+
 WeIq44q4tDdgGVEMFJ32koOzmxBtrOyVJcLGFskapXS99rxD19Fy4ppaV4cRJL6q62r5c+GdiiL
 dEZylan5c+WXXZ2LaDBall/90Qg3M8k2zlo/dvWTVrBdRnA7VgEtAsjVJhbZ6Ab4I5UVTTtcZQJ
 b0asPYNBE5i9uWTlUUc4n0W0Glmlo99WFZlWAb8742JYFOeupNR2zH6bLJJCeyBc4RU5ly/E8Ab
 aLUAOBtG9Uo4nD6g0IXATDHSmbKzklt6PK2r7Wueh38U+4z7hMrglZUVw+EeYw2Gy+GE1skDS+Y
 syeg==
X-Received: by 2002:a05:6000:401e:b0:427:809:f00b with SMTP id
 ffacd0b85a97d-429907473d1mr843305f8f.50.1761290152935; 
 Fri, 24 Oct 2025 00:15:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuz0p215bbSsNFJJ4kgNNrVotmo/dGasCM560NQmuJ8l6WCv9Xxl/RzPR3LioqYRrNB51edA==
X-Received: by 2002:a05:6000:401e:b0:427:809:f00b with SMTP id
 ffacd0b85a97d-429907473d1mr843281f8f.50.1761290152546; 
 Fri, 24 Oct 2025 00:15:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898ccd70sm9547069f8f.35.2025.10.24.00.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 00:15:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: imammedo@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] isapc: warn rather than reject modern x86 CPU models
Date: Fri, 24 Oct 2025 09:15:50 +0200
Message-ID: <20251024071550.226521-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023142926.964718-1-mark.caveayland@nutanix.com>
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


