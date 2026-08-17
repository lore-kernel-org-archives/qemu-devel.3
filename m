Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7739C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvyAH-0007eJ-Ez; Mon, 17 Aug 2026 10:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wvyAF-0007cq-Lb
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:18:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wvyAE-0001ek-9r
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786976289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=BEzVgISWK3iuY+s16Byemvm1Tvr/Fa8yvIkxxUy0Kp6Ss1CJBBC2DRzLycnSNV+Eyi8yr8
 dkUYbvW68cWPCQ8pGKp8qyyeaI+TrH8UjkESbxEdqeRNmC4FLbW1Dw2QY/3n0aCHmDGKUn
 uyWXdscOGe5mtc5dIxTpGMl21/4SuUE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-35ymjtRiNbuWrUA0_7q5Mw-1; Mon, 17 Aug 2026 10:18:03 -0400
X-MC-Unique: 35ymjtRiNbuWrUA0_7q5Mw-1
X-Mimecast-MFC-AGG-ID: 35ymjtRiNbuWrUA0_7q5Mw_1786976282
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49955a9dbcdso22594395e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 07:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786976282; x=1787581082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Z1gMlf/pwmI+2SrQlMSGSRfF/N+gpuZe4ohm69EbIqVV528sUxPMK3dJsyL28fiRvJ
 fOcYKAGnHjT1QDMJEnqWbX3F4ZWw1G92nGJHc1C7UAPiC0XFQQ+KoSi14DckoLgXEZxh
 bKfGtLqlIEo0/EuJVgLAHHHIUZ6++SDPPyQoRd+zAzfUE9mR2ka4UxmOVlbuDiCWlrcR
 AvHv0wlNY6+iVfmbMivVQe/pwyiWeXWOiC7jHn/3Xnx7AGK5P2QE3YpOZSnilUBO3HIN
 IQYY1jguMeFczaQfa6SOB7hTgEFC+9Sj9i/GTVdOUfAn/I0EAP/RqYV742GN2GK63nOD
 aEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786976282; x=1787581082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=LXP5hVQWCjpfSyVzy2AhHH2xPBYsN2oNcx7OhA/Vs/ehDBrs6/S6BQVTAvZEAPRTWU
 ok2bPudG9Yx4yLINpg4ww/M8dxm4V3smGgXWMQZXGu5KSkA5ewpBaY5/MywAxwCNYsV6
 fHKvlhbFJLw3jW4tSk/pq2cGfVJ5HzOngzrYurF+Zcu357DH6zNCx0grUDN28WM6kL3I
 9R1SWnD+GLZ25vXdyIjFyIk+L0ZuS+nOz3zpMlLAGyhQ20dO1bwUScesNxSYtZvOAX+H
 QdoybUclkc+tQdJrU2+EKomzqGOojqj6V6mwvBEgK0LZaYiokZbr4m7Wkrofp5JO4S+k
 PiCA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrV/pVufKSgpFCw3XrMhiMwZR/Z+DIkDIaP0d6vkRL3V4FgobnlxI6xBlxa5iJIwRNinRDxuGWIXSlN@nongnu.org
X-Gm-Message-State: AOJu0YyHOZO7Upi3Qo73p+DR2bqedDEph+f4s30pykIvYjqjQCRSvUl2
 MGumgun9g/DMD+W1k8N4lUeb4C+uA4rRSWoGV3RXQXYRYoXhWw/EW9K+djRuSsaOFSPnNbajVQK
 b55eXWxRNH5lZVPFF4QSet76VvE7g2omaboPL+UKcpzjG7SyIiEWi52JO
X-Gm-Gg: AR+sD13J4DEuMv5ynEvjB5ZKY2nfh7vHigaudoI/x5oTdbkLVU9ZvJKeOyeZtuNfeCJ
 HozLWnIUdm89LBWCQqXEQxr5TAoxhoLjp69o3CLVaYvDLn8JeUZqvJ2edme8qslqt73Uu60jNjs
 nlisOvdUIpcR/6G1KflodYzyjkfCoOihCF312Gq0jpmmtFFUhsczB2l0WccAWlKTvgrSCGg7bXP
 4cHXbcAAK9jgUJqPIJ4Mi0xhVCt5nlrDlwNgoyp5hlQqegAcWymZSPW5XQNqdfu3zrKgud0GrLY
 nO7T2kEyC7UdG/QvRT2EQanXBtC3a+asntG1BDU0Yp24a6Nl9InS4HZbYbYGwoO3bvUNqmQRrr8
 zgpcrejz8ULwS5FTkjPk+vp8tUxWiMM7lVoKPhbH5X9Rxjufh5k87UWyco72PMgg8BNpOgbSAt5
 fImhQ=
X-Received: by 2002:a05:600c:46d4:b0:499:8aff:59b6 with SMTP id
 5b1f17b1804b1-4998aff59d6mr298798335e9.14.1786976281860; 
 Mon, 17 Aug 2026 07:18:01 -0700 (PDT)
X-Received: by 2002:a05:600c:46d4:b0:499:8aff:59b6 with SMTP id
 5b1f17b1804b1-4998aff59d6mr298797635e9.14.1786976281491; 
 Mon, 17 Aug 2026 07:18:01 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3157fsm4238052f8f.3.2026.08.17.07.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:18:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Nguyen Dinh Phi <phind.uet@gmail.com>
Cc: pbonzini@redhat.com,
	qemu-devel@nongnu.org,
	qemu-rust@nongnu.org
Subject: Re: [PATCH 0/2] rust/bits: Fix minor bugs in bits crate
Date: Mon, 17 Aug 2026 16:17:59 +0200
Message-ID: <20260817141759.943839-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802170346.3493821-1-phind.uet@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


