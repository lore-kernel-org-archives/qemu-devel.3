Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591EED637A3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 18:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBHqq-0001qn-VA; Wed, 13 Nov 2024 13:12:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBHqo-0001pP-RT
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:12:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBHqn-0001E9-Fl
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:12:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731521540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=iuO6vtGzjKmfcnv7qbefcy0+QomydfRDTb9Fn5SAtNHodPEns6p1BOscWOGEhSk5rWxCTM
 /eVVXDyjCtp1iK1bMeH7W33BPytM6DpJhNgndXpPwR1pKT1DESwNya/jlD5RccWbZE2ZUz
 /lTSgL9zWaE+MsXfEM94MY9P6q4e/BY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-XL30Oa14PYuQwk88h3LGRA-1; Wed, 13 Nov 2024 13:12:18 -0500
X-MC-Unique: XL30Oa14PYuQwk88h3LGRA-1
X-Mimecast-MFC-AGG-ID: XL30Oa14PYuQwk88h3LGRA
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d4cf04bcfso3591305f8f.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 10:12:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731521536; x=1732126336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=ZBQ+ibaTesI4X4lvqgZNfpcMrESZhYuc/9uWHte8IBkdHvMuopYaKxcUcHZRT/Lt/l
 6X1x2cbWZ8KIl/q34RR2s/mxooVf3sfFZm81sDs3f22bOn79UUKu4zFHDfIrGdhaFUq2
 DkSzKvTcGpKignupoOkUiCbz+TXHk6yDdf2Y3O4iXJ2cWoigynx1C+dJyCGm1vBJH+Qq
 nnNq7FbsSyTHhvrzKJteIPslcSLdwSdXw/BkhSw6LrJD9vqT0UOJx5tp/CxLnElYx//H
 QC0rvwjuViXfzPNePXKoq+rfhz5CeAtPSoxZOOeU1E4Yu7tr/5XmvfSjxdEVqFZxElAT
 LP+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWohFmfMx7MGzwMYvPvLho1V5/1sJ4Y/hrL/Bd0vYdJfd/h5+ZS3c6ORO/3lWBr1hmf3LBeFFutbih0@nongnu.org
X-Gm-Message-State: AOJu0YwtuvW3wKVQnD7UrHDKDYxorfvsX46X0qGJ2XV1+4t2Ot2Z/4vO
 6Kag7hXW/Q04eAvfbzjG/Fozg+NPI9FiW9Bu/Y5bnXLEC71Qmauhog7nydhmKmJesRUa0KE1ivv
 3zSU/jnXOT9p3kiXkR8oVZ60pk646RiTN7NyJLQpwyspOcqIWDRid
X-Received: by 2002:a5d:6dad:0:b0:37d:45de:9dfb with SMTP id
 ffacd0b85a97d-381f187fa3bmr19264896f8f.46.1731521536642; 
 Wed, 13 Nov 2024 10:12:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+72trvgvE/p/NJ+peNSdeNhkTyoUnTod+m1ljQNS8TKkH2MTjgwJEPECMRfinEzaAKY1JUw==
X-Received: by 2002:a5d:6dad:0:b0:37d:45de:9dfb with SMTP id
 ffacd0b85a97d-381f187fa3bmr19264880f8f.46.1731521536326; 
 Wed, 13 Nov 2024 10:12:16 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381eda1433esm18886323f8f.111.2024.11.13.10.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 10:12:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Alexander Bulekov <alxndr@bu.edu>
Cc: Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Darren Kenny <darren.kenny@oracle.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 "open list : All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] fuzz: disable tcg for OSS-Fuzz builds
Date: Wed, 13 Nov 2024 19:12:14 +0100
Message-ID: <20241113181214.1335880-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113163800.355547-1-alxndr@bu.edu>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
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

Queued, thanks.

Paolo


