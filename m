Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D91FC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 08:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnDCS-0001zA-BV; Wed, 26 Feb 2025 03:55:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnDCP-0001mi-6d
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 03:55:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnDCJ-0007aa-8q
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 03:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740560109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=JIY22KbdMyQqowCdzWzrIwhPDL8got+bj+jo6eHiWr1HIKtt7JoKxVi3K+DWw0azwee+NL
 dT9dKsYMR2Onu3abB9EIK0FC0OTW4HJ/tR4KAB8JofdP/dYkBaB6C0IZ/INMT4DoKsI8MV
 QRFjppxdRQs1ZJtWgzx25zOXBff5MMQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-xcEAPVRMOEKl7lQ3obfLIA-1; Wed, 26 Feb 2025 03:55:04 -0500
X-MC-Unique: xcEAPVRMOEKl7lQ3obfLIA-1
X-Mimecast-MFC-AGG-ID: xcEAPVRMOEKl7lQ3obfLIA_1740560103
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f27bddeeeso6795420f8f.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 00:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740560103; x=1741164903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Bdzt1uJRFEb4HDKSxSkBqlH2F1ULda0DlRJVD1mdXXMU2KjnOU3EmTotr0LTtJkErT
 fEkHw4DKfSsToEf2EyWSgTOaIThAxjRzLfejnWSL1z0McuKY5LYnh34p+5ScSv4rC4BA
 /X4PUrWxl6tJ41xSgOO67GPWfT4g5lChB2UwZmjNE+YGBlDZhSkzmDlOu+V57DbPLfDv
 y5n5Q6l4wUFJNfGTlqwZCmyY79YFXghi19w1D29V9dYdQqxZSCC8BO60lqTTXAkACSbh
 Jo5VAC/DuJA1KR7xN8EIhFBStI3R8jbxE7d2553xBhORgnxnxZxbAI29qkgGw1hY0pf/
 K7fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXji3zo+1jicJVDvXpBMS0K7uknuBsQbG19pY0g8ozKib900v73bx7/XPocnSHQry7z9QbU74Zz986@nongnu.org
X-Gm-Message-State: AOJu0YzqB4L1FYLWCMtoMixBYVcmTEoqgKgQYfFxRPBSEYgmv4fDm7OL
 YDqsK/WCLkTjPsaeaZ/EA6g0vRFZlA5hXdcNqx8iAk3bQV1mlzDeZ+6DTu/+ME5ZRsz/+RFdOds
 l658/TNparhyecBGASu+H8o2HQdX1ucVvuDwD2TmkRdBYKJ9CSSRx
X-Gm-Gg: ASbGncsl5uUJyX0Angp0+MgTMWBvcjv8W6vE/TymFjEnAtv9F/oqgZzruSCSdNj0WXF
 HfwH4sQgRT41gRmKGyjGfoLH83J9GEG+wdwaIcCL7Kpb3NRYYVw1URHrlB8LmsSqFHkimNoAaOr
 UdJ1l/Yl6BBfvo68NJyUwrJK+trWhDJoYLfINzr9csawJxVa+QFLMgDagnTga1IX9fe+CGhDgHi
 Etns3yoGICAEE5oe95DwUVHaLcQdA+uwrZAzIzKsVZGfj3L+voFlxH46IHvJTPqPqOH679elAkG
 B8qgfcfEIMAVxk53QFqX
X-Received: by 2002:a05:6000:144f:b0:38f:516b:5416 with SMTP id
 ffacd0b85a97d-390cc60502cmr6737511f8f.21.1740560103368; 
 Wed, 26 Feb 2025 00:55:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7bcU6t/JDzX7oB72kxUeaH3jYnXnKv4dk6DSNoQfqouAJFW1BEii0KOEPy1H7i2G0XU0C0Q==
X-Received: by 2002:a05:6000:144f:b0:38f:516b:5416 with SMTP id
 ffacd0b85a97d-390cc60502cmr6737481f8f.21.1740560103042; 
 Wed, 26 Feb 2025 00:55:03 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abef2667f45sm93069266b.173.2025.02.26.00.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 00:55:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: EwanHai <ewanhai-oc@zhaoxin.com>
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, qemu-devel@nongnu.org,
 ewanhai@zhaoxin.com, cobechen@zhaoxin.com, rockcui@zhaoxin.com,
 louisqi@zhaoxin.com, liamni@zhaoxin.com, frankzhu@zhaoxin.com
Subject: Re: [PATCH v5 0/4] Add support for Zhaoxin YongFeng CPU model and
 other
Date: Wed, 26 Feb 2025 09:54:59 +0100
Message-ID: <20250226085459.545227-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250113074413.297793-1-ewanhai-oc@zhaoxin.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


