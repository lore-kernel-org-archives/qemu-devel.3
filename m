Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F1A10F2862
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6BMC-0006xr-98; Fri, 27 Mar 2026 13:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6BM6-0006wB-If
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:52:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6BM1-00075y-Gk
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774633935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=L9LZfeLB6OgC8kK/SGZ8BUIrwAjG4muW1CCUuEnvJTtyq5Sgx5ea6dAFbibUy++4sJ2zp4
 5KMNHJdomlVLkoCwgTyWWLkBRzMQgSAXJlUO9v+0n0/JBjAIwvhquk4qNixGtevgAo1VY5
 uubzS5jFIi7NdIELG0w+dumFZO7Gd98=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-c1eKDbRXNQupW9ukzuP6xQ-1; Fri, 27 Mar 2026 13:52:13 -0400
X-MC-Unique: c1eKDbRXNQupW9ukzuP6xQ-1
X-Mimecast-MFC-AGG-ID: c1eKDbRXNQupW9ukzuP6xQ_1774633933
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4852ccff333so22158895e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 10:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774633933; x=1775238733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=kJA/g/oX+qKjMqgLJBxIyWTCJquw4pmgovxXHz+2rxDfslSNcnKKZEYYq8qGginFp4
 LUDdgAwJwP9LPtXgkZL9+oRp/z0D9hOXy6ffC3+ICYR3bX9YzvtITOrmtVyjjxtImJAz
 BlI91whNC31W+71pCLLbvDX/xHM3BZmlskoJKUZWkT4CzmRDYU90Hc6cVdDjfKEAnKnt
 fH00How/iJdVgt6KAevfbnI2dFwDn2ZKx+K+mofXQvYc1pJ8ewvLZzrqZNJcuZuc2rHM
 An6TCtiMtE0I792A5AglkCaOasFjnsG9BnWuy5Icqo/RcOzDwQ9/1sHkshhMnNPAlynT
 rjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774633933; x=1775238733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=DPPVAxXQhHYIJ766ZrRg640pR2pXhpQRM7AAo3F42OjxiItcKA1zhVHBUyfO+vr8kE
 NlaJL0vcR8TFt8Ys/QLGAqDLQvKc27zs+PUKgW3unuSeSNgdrTfSdAn91cYCi0Q2bOkw
 rxE8s07z4KJJzGiAnO8ipkuDXVZWqhvX1a7Z8dn3tuJzHYNsvZs3T+OGLaA7+AsFE8TT
 j9eOYLDQoe+ZE4gT7iM9PkYDjC54xLWVLzbHOXmS7+AFEg5daKiPYfwWnx8oLotTVVZ2
 wlcmQEbLVAS4feZALAGnoUo1lWey9XdnSdtEkjxnUUgbEniY0wv6YQqVyLYW6vhcfFEV
 d46Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXpG01YUvnlGFizIFkgJr+E0XeAnuMvnACvn2uzWvytH86WN/VlW7M6ySYTEDyX9VjXDb+EjwfR8Sj@nongnu.org
X-Gm-Message-State: AOJu0YxcvfzjpVR0mlqR79Z9kWcqrMB9dW+P8XgncAGPXy3Xw60uDidK
 Ruc//SDO8wIEYE25XmxrR9kb8/fikoVRPuvmCaBhXkNbQ26RyuwrE3rjk7NB81SsotkM8PWCrgp
 ZFcN4Dj/T7SyrMh49lnjEoAYen6GCyJp97V4+QsHnPqeXk1ljYT9UV/zB
X-Gm-Gg: ATEYQzwya50D+FuatRIkOtrkcacNAwULPn9YVzx77CQZEh/T31SS6plw5A1hAMvlv0f
 +F6rQTS6UkxGtQSyfZFFwznaKfHwjOYGf+HoULuiS5mc6lBR8PbOVtBuzluD2QnFtdfnF3Ady+6
 rS3LX25L1azmoHR1MHNK9K5kBiUbGI0LXkxu6irQufwdZ2btw3K59amnybYh9x9LI5IaLjafC6/
 zh6GZgio6oInEkn2O+VOqwhE/8275CHFNdcJIOb1qiCS45gLImodk26SYQJPcmrS1DfolGoQdKp
 A6Waikgf/uszspLHZilsteCIIpQ/tCoOR7eBn+RJeAFYw/XTnITFkAJpnHiOFaswKWup2GO6Fhu
 xqBMjWkJIdrm+aB4qtmCSelrESsZPa0QD0iRp0JV5lFj3SAvijEiEbA9uREABZ3YS8oY2Q/Y22m
 DrwmulT1pSo7B75Pa7pz/bS4e5
X-Received: by 2002:a05:600c:8207:b0:485:3f1c:d887 with SMTP id
 5b1f17b1804b1-48727ee4d13mr59113495e9.26.1774633932644; 
 Fri, 27 Mar 2026 10:52:12 -0700 (PDT)
X-Received: by 2002:a05:600c:8207:b0:485:3f1c:d887 with SMTP id
 5b1f17b1804b1-48727ee4d13mr59113085e9.26.1774633932172; 
 Fri, 27 Mar 2026 10:52:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b9194311asm17582893f8f.10.2026.03.27.10.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 10:52:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Mathias Krause <minipli@grsecurity.net>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] gdbstub: Update x86 control register bits
Date: Fri, 27 Mar 2026 18:52:10 +0100
Message-ID: <20260327175210.369113-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327143413.254227-1-minipli@grsecurity.net>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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


