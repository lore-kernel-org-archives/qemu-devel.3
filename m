Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B77FCCD183
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 07:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Tcf-0003zT-Ps; Sat, 11 Oct 2025 03:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7Tcb-0003zK-Fn
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 03:02:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7TcY-0007BF-RP
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 03:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760166144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=cBa6ACMAFQywwo0qmrmJv4o8F4rQp56zMhxfDL9DqxGzyuROvWfycCY9fjNDN5qiG/qU7g
 IDn/LE9k1LX7ZjaBUksTLQdP6kJC4LgwOTr0TUwA+LVRpihCpHZJQ8ONyxK5WiNzmZo5tu
 jxZqWE+ELFqq/rCYNOvtGKqpR4EUp6M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-F7Eue-Y1NpS45JZtT3WmVg-1; Sat, 11 Oct 2025 03:02:22 -0400
X-MC-Unique: F7Eue-Y1NpS45JZtT3WmVg-1
X-Mimecast-MFC-AGG-ID: F7Eue-Y1NpS45JZtT3WmVg_1760166142
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b3d6645acd3so294971066b.1
 for <qemu-devel@nongnu.org>; Sat, 11 Oct 2025 00:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760166141; x=1760770941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=ISV5Cv/nNKS2NUkxzOa0r2NTNmKaeLPqswrxX23c0yWTUijHTr0avLj/lMrJwLpqF8
 zwuR8jtYxq1IIF97UHthCWHqDQsx7EhQ32Dl5B9BkAJdA2HMPXhzzRcOrxXk/KvnTep4
 5lMbYZeldXWxJK7NUy4rcxKTSttb64Pl9e6rPZsPquC+pNB+KzW9aLMY5N1iGn0J1tjg
 jPwu44UZUZK66Glpx5F3yJAoYarWX8Z+yTIfEHEPChsjWW4UxLUQ/TnDbBc9PVQohC0D
 kK4mESvBcGYX4TnuaJKvPwM+pQb2vEZsyyGaWr5y9n9OlDabW7UGuLVhne0fIndLAunL
 KI2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2uKminVF80hwe/QD5z3bUYCN/UkisdwmfCyxyB6KxHVS9gIBFCVSdsNi2NacwVqC/6O2eGJpzVftH@nongnu.org
X-Gm-Message-State: AOJu0Yy8xOxMmMDIy1CL03TqQWFq+tVws27q/WrBjR6+Jt80c88SUtcm
 xrHzBnbUOgEqOu1TQAnOqCqMwBJ6oH9Wo43SUbl4OybyVOOTeqZ8dwXlGg2kXIy14WEaMs2bZMa
 XzllE1Zv7zE8aTq17K/g9buMXjI39MWnojejh+f9HACfMskwecF6b7XlxVIMcyzSa
X-Gm-Gg: ASbGncvUqNM+PMBYZerSlFLreOck27WwsEWndUXEk39TRam1V+cfUPdEzsbCWthb1SK
 LKMVUgqG2If1q824p91diVy7OlPUKAoTAusH7XDwA9KXt8QPbjz3lZgeA+flx3bi24/wbVxUix9
 /MVmH80nEEWHg21/eouEdLW+zRL3E54DY5oy8e8/GiXuFcNhEoOzjFXZQa1zSqegMBgahCTv9rA
 EynoHQIyuqJsWM34VrCz9fsPcpTpFf6GEL/XwWDYvxoF+i+uSprDXs45XTlf6cVr57UdgpGQOns
 IYvRlnHD6HcxUP31BJsOeOTJQQM4jIedp0QRCqw8xHttIN59Oc7Ys7j4rJp3B1YltzhPoWRWHOn
 08iRtH7qO7/NfgRnVdPZcYDhQqN18hG1jqLiNaPIrAZa5
X-Received: by 2002:a17:907:1c0f:b0:b40:9dbe:5b68 with SMTP id
 a640c23a62f3a-b50aa792c29mr1323296766b.5.1760166140836; 
 Sat, 11 Oct 2025 00:02:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5OrkATRsLF1SM/7eNVOs7v3IljUCwtF03UsJxXTO7GzhQA6qsVWyLAiZxJrw61q/YB4Tqfg==
X-Received: by 2002:a17:907:1c0f:b0:b40:9dbe:5b68 with SMTP id
 a640c23a62f3a-b50aa792c29mr1323294366b.5.1760166140400; 
 Sat, 11 Oct 2025 00:02:20 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.231.162])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d67d2da2sm428678566b.33.2025.10.11.00.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 00:02:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH] i386/kvm: Expose ARCH_CAP_FB_CLEAR when invulnerable to
 MDS
Date: Sat, 11 Oct 2025 09:02:04 +0200
Message-ID: <20251011070204.864385-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008202557.4141285-1-jon@nutanix.com>
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


