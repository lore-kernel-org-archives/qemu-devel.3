Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8E2C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 07:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucfyu-0002U7-2P; Fri, 18 Jul 2025 03:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucfyi-0002Qh-3y
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 03:58:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucfyf-0006Ow-U3
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 03:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752825475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GOn2BSUf8DrlsSe15fpzUBSFAezNelDy/nuMtbmfih8=;
 b=THaTvHH1jjryczZo2TyxRtbNb7xs5yz2JtELTRVQMVdh8I0w1vSDpE1wVAQW6oDLNZSssC
 6scT0wlti/tQWDa/LOFwQkyxdmnfDPzSJZA0dhhVaIp2CeeAgNnW5JtlkITjLqAkVXAGe5
 21W2Ew5Xs0CQWnq2wsp5QmKGrQHj/Yo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-yTseaDRDOiuLLtMxTXRzGw-1; Fri, 18 Jul 2025 03:48:29 -0400
X-MC-Unique: yTseaDRDOiuLLtMxTXRzGw-1
X-Mimecast-MFC-AGG-ID: yTseaDRDOiuLLtMxTXRzGw_1752824908
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a6d90929d6so734848f8f.2
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 00:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752824908; x=1753429708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GOn2BSUf8DrlsSe15fpzUBSFAezNelDy/nuMtbmfih8=;
 b=wvUd9zovnuV3/2GxaPy7Vn5mbAR9axZML/FV8vAKS8Boxso2OaJZKaSRnmo+sKVs8G
 b2D4RKDrfW5j5B8MozqVJRJzToMitZPhEn1ALsN9Gd+V4mJI3G5SFAkdPiGr0OJ8A1zT
 9fHHJ0xT/YpJMflvrjEDafI2w/Z1T3+RUUdEYLHDm3VwDY2odLbLctz57JFw+2F1oBlM
 WjLZcXRfZhl2esEnsFOS4CZPB7nr9bNNPLmpvd6bhh1xD+apqeJOQP6nRerkA2QucJel
 58DLMab6a8cx8wqzFo2Y1Z55BHYJYqP9+PLGWTur2zbKiRjSYFmzghCFHuHXjoA/a1+q
 QXxg==
X-Gm-Message-State: AOJu0YyXnWpUTjplWbZSMOLMq7a/zoIwgSPbeQ81FtWBD8ZLdtlkJOzE
 aPygQEpUaHMGfNlSXOzCfxyRaBwVkTa3m1vIc7AhNsa/luWuPAVXinkbME8TSNhDUBp7g7W1vSD
 Z440I42lCU+fQNhjkv72QVpqiwov/7jR43JbDb9Zzo3hN7FbR6xvtnPVx
X-Gm-Gg: ASbGncvuz1yBeVyynA9dTzLBr28SfJF0inyKciby2dA6r1MYmpKWiN9oq7mDT6hrjuh
 MkdqRwfQR5g7jnyH5AqXSxFTF75KBTt3w2JRibSfU4VBPHSFcVxr1xY5bmb7n3bGHtVkg4626+f
 dQ/Ztr4uCP2IOcZImNmxTV+eRqQplYUtlLKVbjcDV7KilSybO3STztSbZJshkcseU3gO3/Nr0au
 UfEqztyG+SOrQaKeicfjkEz7pA88m2ULLxsfJCRM9gDaSEQQe2aiKaIUHBESWAdaWfL3gI33Cgt
 cZdBcTGzvTbKbn12kCvIDQrbrWYTWvli1/i5CbhUn8I=
X-Received: by 2002:a5d:588f:0:b0:3b4:990a:a0d6 with SMTP id
 ffacd0b85a97d-3b60e4ec65dmr6986258f8f.19.1752824907760; 
 Fri, 18 Jul 2025 00:48:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFncB2nK/oOUu5mKV2yAN1DW2VPc6AOBqhjl2B/EJa0SyzAtGRhHsWDZ+nN5E/WN2XukIjMvQ==
X-Received: by 2002:a5d:588f:0:b0:3b4:990a:a0d6 with SMTP id
 ffacd0b85a97d-3b60e4ec65dmr6986245f8f.19.1752824907395; 
 Fri, 18 Jul 2025 00:48:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e7f2bb4sm70232135e9.8.2025.07.18.00.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 00:48:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH] rust/pl011: merge device_class.rs into device.rs
Date: Fri, 18 Jul 2025 09:47:48 +0200
Message-ID: <20250718074747.367232-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250718-rust-pl011-cleanup-v1-1-c71b1d6a69a5@linaro.org>
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

Queued, thanks.  But for 10.2 maybe we could alternate in preparing pull
requests?  We'll see.

Paolo


