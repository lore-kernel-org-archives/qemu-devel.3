Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA30C7115B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 18:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRadg-0001M7-DI; Tue, 17 Jun 2025 14:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uRadU-0001LM-JK
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 14:02:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uRadS-0002e6-BJ
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 14:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750183333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=WLPKDtxMn9Awk4834/Nslstq0H/6D/AUFRTfiDMbtH7lKu8rG92A/KRwDl2TNRO1yEm8qI
 cQyyascsKmKbaBO7iV/gCrWyFygWwq5pqUCerQ8zb/wAXgBYGo9gNISShav+g/iH9yYZpz
 Fn+kNs42kScomlMMarWqB/Zxccuweig=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-oUzWJz12P7SN_rox8FH7-A-1; Tue, 17 Jun 2025 14:02:11 -0400
X-MC-Unique: oUzWJz12P7SN_rox8FH7-A-1
X-Mimecast-MFC-AGG-ID: oUzWJz12P7SN_rox8FH7-A_1750183331
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4e9252ba0so3021319f8f.0
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 11:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750183330; x=1750788130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=w20lwGyyMhC0Dei+57e6IcZA+Ae8qejG9IyeM7ykqI3PYZsqy1qII8x1WkqVlGxi0a
 5sTwrkVE5PLXCmQBhFxAlXc6XYFbGbfdZtJ3+g3CfJtIW+3YFtStVMh+w4Q0zG5EkkSC
 Ihyt2OjmI4+YAGOphDU/9CZ1oVHkp12eTlycVoxhC4Fi3JTBO0JxeJiwTazbxlPhb8BG
 LAG2jpWZAZ0nw2LBgL8wQdi+F9w8nQtFl5sXeIlP1QFu5rr8xa2wALqf/fqTDdWudmZZ
 /R5zv/LD2ZBh63vx80gyGiD5su4QBB0w0LzFovaIJ6X1Nm+dL9i3ffenPqYuYz1N6TXJ
 V3mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4q9dem1g9C8GRB/u0AJM+z/Xr5YAycCRqh4QDFym/fv+r0bWAuRkjU4+JWuehEQUGJbQ90Fh/8xKE@nongnu.org
X-Gm-Message-State: AOJu0YzKGSMNylZb/wdeMPoGwilhHhQhPBjU96dktscbhSw/eEAp6GIl
 iB6t4LEzHV07z2tCNOHtED7bSQqU3Meq7xVMmNVPPUpJNtxIG5zPbieECn6n8HmjcRcHvvhgtNG
 zKb79nu+5K4RRnjymlUngV8i5px1ribSNzK7hVu/WICriX+ypSv44VYTq
X-Gm-Gg: ASbGncuT7zMIHO+K6sZWnwfzMqAJ2+MmkysbTSnXd/SZADn4p3k4tfvmocgGhHG4p+g
 8xW+SFYV31KaLBOJGKSiOue0Xmk8o/+Z6w/VzauI67ngJ8hkGQC2PLzaAM9UtpEZC6hAhTQLDrQ
 YCxgSgv9uqTjx7JZWq998yjHRnodkwWehH7+p2z3OYFPpcafxRODQbAH3q2sQpGgXbU1X+RSXA3
 LOd5Ko1zUEo4iQozOswGt5V0+qXBRfTlIDu3I5g/v+UD4GqfJsk3Qz7wY4t1q7oMD2OBq/B/hKA
 k4tImp4GZVvPw5h2YKVXZOG2TVE=
X-Received: by 2002:a5d:5f48:0:b0:3a4:fc3f:ed28 with SMTP id
 ffacd0b85a97d-3a5723a2bbbmr10998655f8f.29.1750183329810; 
 Tue, 17 Jun 2025 11:02:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF22y2bBNCsAgDTtdHAlbvdqNvWiTN5asbIGF5wtYdxjuvTP7ZuAgmOktvIiOKNSrqXct5+Mw==
X-Received: by 2002:a5d:5f48:0:b0:3a4:fc3f:ed28 with SMTP id
 ffacd0b85a97d-3a5723a2bbbmr10998548f8f.29.1750183328524; 
 Tue, 17 Jun 2025 11:02:08 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.88.147])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b08c99sm14757000f8f.63.2025.06.17.11.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 11:02:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
	qemu-devel@nongnu.org
Subject: Re: [PATCH] i386/tdx: Error and exit when named cpu model is requested
Date: Tue, 17 Jun 2025 20:02:05 +0200
Message-ID: <20250617180205.270073-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612133801.2238342-1-xiaoyao.li@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


