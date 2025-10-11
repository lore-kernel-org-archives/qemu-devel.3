Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA43CCD183
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 07:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7TaT-0003Ot-6q; Sat, 11 Oct 2025 03:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7TaP-0003NG-HM
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 03:00:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7TaK-0006hv-QF
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 03:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760166002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=gRlkDAKMjroDC3ZyShGHNJT1+RVE3ClOnd8y1o1eDh1h+3YphvR+DS3S+iKf4zlTt1RbQ+
 re6UwYWWOoRhXRFALs4lvbaGPdxrxORjhXA4ujPXT1TTZrYv92WNSxA2IAYVWaKw8LiBlw
 vo0Qum+Ku4Zp02UbsSJYT346EbeV5pI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-LouzoietPHeuI4uG4dGWTg-1; Sat, 11 Oct 2025 03:00:00 -0400
X-MC-Unique: LouzoietPHeuI4uG4dGWTg-1
X-Mimecast-MFC-AGG-ID: LouzoietPHeuI4uG4dGWTg_1760165999
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b4635c413a7so210823566b.1
 for <qemu-devel@nongnu.org>; Sat, 11 Oct 2025 00:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760165999; x=1760770799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=YBW4YuHplf5mYuNBwgoyvDOfu4IINkHB8ytAATCv8xkuYs9WQO3K2e3I5le5OC+hmt
 OpjB6131jDdwQwsEBFqLWcPWIDk4yAojuh8OPY1eqPog39xBPZUc/hkSf+BNnAJS9JV1
 f2G52vaXdcVQ8rx3udEgybiTC7GPJWUg0IEQ7MtFwsDn2+ih5JCEZkHbaDOM50rbCjb6
 7WNGDz3yDvTqutgKJR8Ex5OEsVC0KI/8HxzaajO9+sKuk26XWePL7iU2eczErkxDqgna
 h6vW8SKEui9uPz037Gg7qLH+36kkSC5Byt8y0wZonotYLD0K1slCSqMHDc2y8pKoneP2
 2qag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzmadCoxNitGmtcgxucg4pTWtJ25OlLV+tabtjRsId8yCQEELTM1MbVNc1975Nw1GoFLihK5hOjfI1@nongnu.org
X-Gm-Message-State: AOJu0YxAfUTiIigJuFKZr0M5dkmsSFKs3zle//QFGc9A2xDFy+L/y2yD
 WpEpBDB9ZlXTMyXMsgdk+qJp5OKIeHPKWzRlqR38veWxvSFcB/VAFEbIWsNocV4iYQKoJ4ualoE
 t4qb73CXn5lpw7/VGPmZAfdN44Qi1OQo508W8NagPQ5xA/wEpVYcH+bGS
X-Gm-Gg: ASbGncvBVv0t4fval9VKGx9MRwi+RFwJen/294XD3FXqrPhV19P13O76xUEApUhfgKN
 E2nz1BZJVHTiiPOKvYGQB1c/Mivs11D9MUUUk2nzcHPvzV5sED+7eWAfQsM6yyb3ortXj4+5aO6
 5xtMVZ/runrYtEFrUEbSDSsKDcoXhlLSkibSEUI1fB5MVp0QqE2tnOeHxRhbxAwIS3dQwhzBgB+
 wiPKSMXEj049AqtFGhfk7m/h4G2rZAvyYqGNGGJrbMnN5/AwiOjZmGtHqpUZfEmEFCiWqOPzMSS
 Kx8qoCUMemPgjud02jzfN4BvKi7XsD8X8b54qax8mMTOAXf4KJ8UhByGEWNqKKjkpkMXLgS4bAk
 olxoFwbKKAh7l54J65ZKoxqBPf33uGx4I8XiyHT2LcaT6
X-Received: by 2002:a17:907:9720:b0:b3e:b226:5bba with SMTP id
 a640c23a62f3a-b50aaa9c3f5mr1447321266b.15.1760165999299; 
 Fri, 10 Oct 2025 23:59:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPnNSU4zb4wsCQp72U98/i2cXPRlcB404diesL0aSt7kSdLKSD8sQxsP+V8emKdZVmLu2wBw==
X-Received: by 2002:a17:907:9720:b0:b3e:b226:5bba with SMTP id
 a640c23a62f3a-b50aaa9c3f5mr1447320166b.15.1760165998951; 
 Fri, 10 Oct 2025 23:59:58 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.231.162])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d65d002esm411879466b.26.2025.10.10.23.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 23:59:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Mathias Krause <minipli@grsecurity.net>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Subject: Re: [PATCH] target/i386: Fix CR2 handling for non-canonical addresses
Date: Sat, 11 Oct 2025 08:59:56 +0200
Message-ID: <20251011065956.863870-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250612142155.132175-1-minipli@grsecurity.net>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


