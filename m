Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DB8CFD37F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 10:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNqQq-00023h-4f; Tue, 25 Nov 2025 05:38:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vNqQo-00022s-8A
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:37:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vNqQl-0007SU-O5
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:37:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764067073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=MPx4Brzu56jaP5b/rbUNAZsfcCGKLhNqRbRYy97vuODOk/bA5h6bwgx9cvybp4URpkYAZ2
 vIOSIho62fJyVAnKbQKwx6As6+42ZP+kDK9h6i30yUvIioJkSiCQe9+KL434I4je/u7sJc
 Mw9sbybpt0RoJZvEfQtt0FqcUyvmTVM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-pB_OSCyvN96ZbqCcfCnOgw-1; Tue, 25 Nov 2025 05:37:51 -0500
X-MC-Unique: pB_OSCyvN96ZbqCcfCnOgw-1
X-Mimecast-MFC-AGG-ID: pB_OSCyvN96ZbqCcfCnOgw_1764067071
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-40cfb98eddbso2951647f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 02:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764067070; x=1764671870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=d361QuiZn/jVLD9YCo0ZNjRuBtaTe+eBO0+IhL8SRdBwTCxnLB/kTwmBm/9G6jve4G
 uEPP4W/flxS5VXbV7m9iO44i8QA2m7s5LqfBv3vJX/U+CRfZm1sMKK1f3kcsadru9A0G
 skL5jaY4Ikoj1JDMozkC3Znn4bO4yZcC40Fn5fVohkvUJxXuEfb5gJKhU/iicyjOWaNx
 nFBJMjiAQNLDLXaxUIz8ajwf5YPItb5s3SUbhdbMaTrUBG2Lq0yU8W79/GJQIB/fC4yK
 pvu6zkMueXRGhj3jF963RBBNwCbAAcDcIWZOEuClyCEaJvBl6U1y/bQpXsXtRULAAQyG
 M88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764067070; x=1764671870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=l+nPviWIpuGALVljpwDZYd48uPbmD/3BDop8TS5MPsukO+2CqsY+HHR3noj3sfn23z
 eMBzOObQOqLtYgpM75ONZmttq2/m12c6c5omEFhv9m2tHlZTWd6T8AQ6y3grPqbbUDx8
 breus4pUQsg3x4QaHmG2rhiGHheZjEYERR+owot9aB9O0WS12Ciq28okrorw/bjonsS6
 PbAEDPbQprTM7pOlx0fcpJDCKJH2mX74Rl5RjWGes01rWTPhQjwLKnq1WDLP1MsUiuCt
 i6C/xjrQiWNwZPdm38vxOf6HYQ9EZjf49deYEeFSgWK5BYNAJ6HbiwFj+l0E33gct/a1
 ar5Q==
X-Gm-Message-State: AOJu0Yx2Yckbg0rjxbEjr+GWGmeicUpojCSjt/2PHPBCPQ7WqGqfAzHw
 uZ+mOmfi/pAXuFT0OgNCmz18BBnuwlce+xXlUGJNx3B5BCACewibE2lMq6D4P8gKh+jZtfxJCcs
 Eh33FHD0dQS+DEYGKIg+gCpYClqlThWFbqeGZr8iS20Hu3MqvaE2dkqP9
X-Gm-Gg: ASbGncswim1Lc+6LKan5GaDME+FeiFdfYREYBZVCv2pjGMSLbSPzUjkTcu6OyCCEYAP
 1vUmVbAFHGNZQKfQq3R5PRuXPy4mT/C9oz2btrhqjSrj7V/jsNIdVFz2HEm1niRrFqnDN7cl9IQ
 8rqiyNbqmAFHIgUcrU6WSlybcecGybjgZQfdLZO1bZeG0KyR4ZW4M78a/pVxYan7DpuwkNOnOXp
 ycMrsTc3ir/IC9E3WYpbexIMWH9j+pOB+h63zqoxY3FcJ+IULjKDW6FxBxmFjSpZ4xXeUEuQgC1
 LpMi1848mmjXqqIbOXNu57Z+IgKkLd+eIYvuNt6cO5YZG373YVfe+Z8u5nUohIyvAxePppdxZm9
 2jZvwddzXvjmhfNfxghA08k+TvuL1wElaj4Ngv4oOchsEy3Bo/M5f6oULyb164Nw5jZoK7YQ4y4
 PUSCe9i5Vby6Syw1g=
X-Received: by 2002:a05:600c:1516:b0:477:14ba:28da with SMTP id
 5b1f17b1804b1-477b9ea8f78mr119762105e9.5.1764067070593; 
 Tue, 25 Nov 2025 02:37:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHULk984gW1pt9XBGwHyAZGYSiRX6fCnEwc35u/qID0TOVrBa5kMUwpLLIYtidkFhlGsKF7bA==
X-Received: by 2002:a05:600c:1516:b0:477:14ba:28da with SMTP id
 5b1f17b1804b1-477b9ea8f78mr119762025e9.5.1764067070250; 
 Tue, 25 Nov 2025 02:37:50 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf3aef57sm232315995e9.11.2025.11.25.02.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 02:37:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kvm@vger.kernel.org,
 eesposit@redhat.com
Subject: Re: [PATCH] kvm: Don't assume accel_ioctl_end() preserves @errno
Date: Tue, 25 Nov 2025 11:37:46 +0100
Message-ID: <20251125103746.856877-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251125090146.2370735-1-armbru@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
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


