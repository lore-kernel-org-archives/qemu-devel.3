Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C15CC30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 19:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP64M-0000C3-Hc; Wed, 03 Jul 2024 15:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sP64J-0000Bh-Gp
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 15:55:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sP64E-0001F7-I2
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 15:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720036501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=aOnUBmYs0p2XIj0g12u22j66oZ6DyJgYPrfle4Gvh1WfkFGvTlFKvmZHnivvBWXHqa9c1R
 lrrhdtIsugt1sN0Kt/LAdsJyXJYuywdT/vGDoheICUB8IAEXnvegmEQKAViU9jm1o504pQ
 hSkJhroBXYgzfN2Qgp5aO0wtlk1wkkM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-4sBrg1VmPXe1_3graY4GuA-1; Wed, 03 Jul 2024 15:54:59 -0400
X-MC-Unique: 4sBrg1VmPXe1_3graY4GuA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4256f895ce8so43349665e9.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 12:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720036498; x=1720641298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=jtY9/EJ9SR1wG2Wk7/wuCGng7/TK5fgaXU0cEncVP7FgKzjyh1n+c4OwGI1No9eVEy
 EpfSKQRDZdK2v4qGRhXa5HMXe0XkRs5VE/lDsk4/nxbisXRkhtafKDJA8fvMJ+gqEuay
 qpieKS7tmLTQG0PYmjijiNgrGRTOXG1iNsUVv+QT0QUmZYR91o5N75KHAjm38u5wttgC
 EbM8e7pkMgXiLzy8fJMWFeyi6aCtanDrMutXFIDgk1Lf0hEruyH9eKBjnI3iydWf905C
 /1LLuDR/pYiUGudsEQ1xfxsVWKLc0uYCsmUqvawEo/VpxhMBoHXu8+SsfK61YHxufEf/
 e4LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhenQfhUpHnoHVF5qjQK4IPDvLRdh2xcPmQbzSrrPEZ58yW+LdKmsnFaqS50Rx3tKT3u0vuQLv9ZhbkemkrqJcAJd3/Ls=
X-Gm-Message-State: AOJu0Yz5b+dgz4+42qCI5Inrwe0CKB5f91g2I9N4gAc+eoubPysDFKaa
 aJYXPMcOdzGGYWojF++kJNWbxJwIlowWHXVtheg8fwmu4DMNDJBZKfS3qP70Np/BscUlMofoMg6
 8qstLgIeXChN2tX298uKbLhEUt70XqAev45pjQoIJIJ7YLgWR8dRN
X-Received: by 2002:a05:600c:491d:b0:425:6d66:e432 with SMTP id
 5b1f17b1804b1-4257a03a6c8mr83522995e9.22.1720036498676; 
 Wed, 03 Jul 2024 12:54:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHci07cuekk39cK5h0w/VlQmpHPau4TSbfAH7LGFHdx4NFoZXkOb/Qxnv85TaFEa9q3SfZWYw==
X-Received: by 2002:a05:600c:491d:b0:425:6d66:e432 with SMTP id
 5b1f17b1804b1-4257a03a6c8mr83522935e9.22.1720036498352; 
 Wed, 03 Jul 2024 12:54:58 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264893a769sm1431435e9.1.2024.07.03.12.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 12:54:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] char-stdio: Restore blocking mode of stdout on exit
Date: Wed,  3 Jul 2024 21:54:55 +0200
Message-ID: <20240703195455.1721565-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703190812.3459514-1-maxtram95@gmail.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Queued, thanks.

Paolo


