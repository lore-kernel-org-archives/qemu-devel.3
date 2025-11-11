Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396FDCCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 08:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIjey-0007QN-BK; Tue, 11 Nov 2025 03:23:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vIjeu-0007OX-Pg
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 03:23:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vIjet-0005AR-4i
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 03:23:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762849400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=V7TxnVvrx4EEWD8RsWcTnH0GyTKLD0Ia67fMTZb8OnqldModXc9xMP8bKgqttz6y/WmqJk
 YJxG5idzTstRNCIWLrwbV5xoY2o66Pzf0dRI6FTFYK6eSOF06m+RF8F7OyBL/ra0ouoG3A
 LDTxjld+PaWxstTHsOh4SMb/wCX6nwE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-POLckrtwOna_xJR1iVLmzA-1; Tue, 11 Nov 2025 03:23:19 -0500
X-MC-Unique: POLckrtwOna_xJR1iVLmzA-1
X-Mimecast-MFC-AGG-ID: POLckrtwOna_xJR1iVLmzA_1762849398
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-475e032d81bso21631915e9.3
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 00:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762849398; x=1763454198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=rfUAohn9l92P3NN9v5FsR87mbXvIlQC8MLc67pHiFuFJqoS8KyK5T2z0zGBYl+7kmx
 1rYZl/c/z0fklZGy4liZWpADdI4j4iblFTsxGQv7vvuo987v7uLlvtReW4bZcs0XzzTG
 y0SuRt9RZYTqMHKIttjnnH5ZhnD540Uj2BWNuM4fAl2KUhEXwuSwEfy0/zlcULzOaENn
 w5vQmHglFAuwuSCDG2IyIu/gzKq0KC2zvrJ3WubEVBciMzXeGp64dx7UctmN1gxvudhs
 V6lCnz7R2VqAp/sOmGrjd4PpSsE5NiweJ1oTOTCGmE/Vwphod4eRACTcZ/+5lTWc1izk
 8BLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762849398; x=1763454198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=o162asobBVdJDQ7QtiEhqoD9C75h531eh/BrUFgToKBtjOkecPS7ei1j5JgHMt+cC5
 op7uwTufHIujE3eIFfcmNwubSqEb6r+FSCcRRsEvaR59kfiGl8VrhJxX5xVb+/OKdFPd
 d1ACPbW5MtsgWvv1AFEmEIMutKbpcQ2Ujb4Uceu4shqLyTlUl4Zh8EhzPVoL4zf3HaYK
 440hyvgeyZHMRXxjFSGzuIVTwKsWgFKWw4HH/HFkW86HVBS5Nq+qM7Fp333+IxVBx7Ct
 dSTkxnGUn3QSUzNN6EBAF6CJAS6iR+QuiqDIZwhod4Xj0t8xFO0gIpEFCK10C8qQVwet
 A+sQ==
X-Gm-Message-State: AOJu0Yxg5NMw9sqnYicTDA2jfF9PEuBifBXTN/3brR4h/wFTrSNjVa8Q
 LsbT26Ct3ab99GG0cVg5hKp8kp6nf0gmsG/7WI188lWkjlgZVBnRt3LybryKR206NSnPNXlNE4H
 kEWL7xEGp0ooa9bWsNUfk5p1qfvtLqO7RNtyqMkZPs1XFqR+LUvHl3qbR
X-Gm-Gg: ASbGncuNMAZgchk02u7wUGRi8bzJtcfW0E+nTQ3hb+vJFRly1dyiT5XCxg3Zg4SQCMX
 riZjh2dxOqfG+yP779VGW2i1dfFYxiPuiCgN46jqEMBAB3mwyIplfn3T7akWHx+Ly/0RqUBCWHH
 odzzN5eS+mgFZH3BqhwXey8EPrjrZ8VBaewjm9MvEomkXRtun9uedKbBF6rFA4tP3P0ac0F2/Ek
 xVw/d6hunPyZZj4OJqq4XAxQaFzTL/xg4gY4BST6yEZ+5yiPiTj6OXgiT0r9JKDt4NGhhSaCqDd
 j59hjmvRKm13io8qqJ+orV9lcoyhUxaxeQo7RG3avN86AH75knZ9UkaqQGeCsEZy6HNGdEFJgx5
 dorv7ifaVPOhBq/pQ9YKWxdeULAafdBhdLyi+S9EbkK2/Tx90PZGKqPapt8qx54DM0Y1ZFJL06U
 5RBX2wOw==
X-Received: by 2002:a05:600c:2297:b0:46e:4a30:2b0f with SMTP id
 5b1f17b1804b1-47773465fc0mr74951825e9.29.1762849398117; 
 Tue, 11 Nov 2025 00:23:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaPHyFWp36Iv7gT3TVS0tlJIb5FjOTceTB1p5zykIFjyiPFpzDthJFRBzTAeXIsf8xVn76GQ==
X-Received: by 2002:a05:600c:2297:b0:46e:4a30:2b0f with SMTP id
 5b1f17b1804b1-47773465fc0mr74951635e9.29.1762849397718; 
 Tue, 11 Nov 2025 00:23:17 -0800 (PST)
Received: from [192.168.10.48] ([176.206.111.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477789f3f0esm138597975e9.6.2025.11.11.00.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 00:23:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-rust@nongnu.org
Subject: Re: [PATCH 0/2] rust/hpet: add trace events
Date: Tue, 11 Nov 2025 09:23:14 +0100
Message-ID: <20251111082314.24152-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251106215606.36598-1-stefanha@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


