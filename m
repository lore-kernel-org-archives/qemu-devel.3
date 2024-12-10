Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0CBE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 17:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL4Go-0002Rd-IN; Tue, 10 Dec 2024 12:43:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tL4Gm-0002QP-1N
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 12:43:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tL4Gk-0006mH-Q6
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 12:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733852612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jM0QCqkNw+tw30/yqQHggbdtPzxBBd53/xohxOS8uf0=;
 b=HZa8ALg30i2A1AOHL63LSRe3TfMwy1wZtYhdx3XMe7g6Yr8pKChUrl6Zo2ptQoOV+BaOGo
 y8qaHr/LAStVfSnAatUgMz9Gp3TY0UkQI6xby9fjeVaplor3xTqPJ4veiVKMtwtZCxUfz4
 Op8kvw15/UVxolJQBE3bLXuTrWdSw40=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-DE9IYoYTN8GEhiIMRva68w-1; Tue, 10 Dec 2024 12:43:31 -0500
X-MC-Unique: DE9IYoYTN8GEhiIMRva68w-1
X-Mimecast-MFC-AGG-ID: DE9IYoYTN8GEhiIMRva68w
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385e03f54d0so2442682f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 09:43:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733852609; x=1734457409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jM0QCqkNw+tw30/yqQHggbdtPzxBBd53/xohxOS8uf0=;
 b=m4fTkc4eQ2tcT36ogyf3iZerit/r5yS5+6fhLkDPSKFBILZ/fBzE0NvFLnFrJYTXpb
 VYuTBlv0eU9Yt02IAsaNYLBGajjTvQNB8/ZeKD5y6MGKemLrxA/ZYOpWSTbfoNOWwfSP
 T86z0KSOn/7cMksDkuhJ+f2TrK5NkIZ+p4ZV4/XMivlJ4f5PFXH1ssM7RDD9DsMiWW0s
 h4oFqbzfwPg/Mx3knbc38KNKRoB8LShFYOwgTGdqa8j81vO4sAJ5JvR4F2ih7GH3kekw
 AlSflTaUq5k6psZK3VMiteL25YA6TUH1g76q7yE6ibbc/4f4wOEQLacBpeFIkB20UCvC
 gKYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlvld8fsKGuhVKTA4Xq5DT0966GEeCwnLiv62OA3Au5M8VGvmBHbgvtCD0ECQexRyamXpndnfS2WqJ@nongnu.org
X-Gm-Message-State: AOJu0YwflWKPRH26rKKjvZOeqnXbao0nwLbQ6b9LcsMuNT6bg5/jUR7i
 NsT/3dRvDv7nL+kxjDzCZkUR8EqQbsPgQ5+eQGIoV1GBikTbVEXomitSUBtFwtfE9LlGgQFGrvq
 FIaaDO7KFMpUmU090xQ4gCbknBkQdvHentGJu/1DlQWZ6LCl/JzOX
X-Gm-Gg: ASbGncvJNLd/u6TDnHq5/jAG2D8kO6TUex0h4K4P0s5anLggn0heMknk4gABNjhBNB3
 Pjw2C3C1Ywh74tOC4P2BRobI2WE6n1GmZ2rkDb1+y3zkYUP8cRpIWFF1K10g684S1SZV01+OugZ
 cC1gRTfAfUDgjw2tCV4jZu2Vo4wX5UCxxtzDX0YdQ59EAOs+YyklBB1ZBZ4PA4qfH2uLXQU2lG0
 Bb0hZVSZwlj5XTEBuN5wgvbLKEuc8aIYt2/ji8Diei3tqcamQUiWv3wfA==
X-Received: by 2002:a05:6000:188f:b0:385:ec9b:e442 with SMTP id
 ffacd0b85a97d-3862b3d09bemr13365199f8f.40.1733852609644; 
 Tue, 10 Dec 2024 09:43:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnOKSFzOGxhVFwHR2Iyo8zCpm2K5SZ/7kQ6LDKbJ5ZVmqQdmiCHIco8EIG25nSKO7TcUdkGw==
X-Received: by 2002:a05:6000:188f:b0:385:ec9b:e442 with SMTP id
 ffacd0b85a97d-3862b3d09bemr13365173f8f.40.1733852609333; 
 Tue, 10 Dec 2024 09:43:29 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38621909952sm15979655f8f.69.2024.12.10.09.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 09:43:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Subject: Re: [PATCH 00/16] qom/object: Deprecate type_register()
Date: Tue, 10 Dec 2024 18:43:04 +0100
Message-ID: <20241210174303.240227-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241029085934.2799066-1-zhao1.liu@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Queued, thanks.  (I was waiting to get closer to the beginning of the 10.0
development period).

Paolo


