Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51158EA8118
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpo04-00019I-JZ; Tue, 10 Feb 2026 08:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vpnzw-00013u-Us
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:41:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vpnzt-00034T-75
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770730903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=aRD6edhCF7wsYL5U3FgvkggYdKkWkuRaU1RW6M+8/hEOZs8yPCqKkKDSN9mfel/ecZMzhv
 6+BSMsjLjAG6l9MKBi5JElDJSUxZPMkxwRaQGzRlI+ZQkRMy0wout5zZZerNdDSQDqgxkb
 EQab09CF2AagVUunmDJ3BbnYKO69Fjw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-Eyowjk67NsOMMKXdO-QQWw-1; Tue, 10 Feb 2026 08:41:40 -0500
X-MC-Unique: Eyowjk67NsOMMKXdO-QQWw-1
X-Mimecast-MFC-AGG-ID: Eyowjk67NsOMMKXdO-QQWw_1770730899
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43768e2aa4dso2111846f8f.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 05:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770730899; x=1771335699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=qc4WXrG+qW6k2uVPjgy/Y7hxw3n2VgTnYNRFO13uDVhHzfPRq4AHtO8usn3MBLOejk
 cLKk9u0i63RMebrOpiJyW85SKM57XEXYrksnzyEnioYOlvTKU6MyUdgSA9qMSftRLJIJ
 wUsWfCNxp6EkfxBiguzrODzutfFXL1OJBPuCWaNXrWeFX1q8PaMposnhthNiY2f8AMtD
 mJH6KwICDOb9GZWf7pVrCqTBp3OOX7k/vcydQzq2T8PXfUsI/Nb2fKdwJvwPp1TzAGWn
 TNjCv/ZD8idYBaAO1WpWJ7gEx541sjhOH7TPkHGim2xoMQYZ0Dg6Ye99SuHp5sw0m/ER
 TI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770730899; x=1771335699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Jtf5KAXPpqS6Cyas+wALBqi2f2X6SSv4ysPS9DT9nIiNlSWz+GWtqitpvOAaMNK6Dw
 rc+3SxDYPlK5nlpt4LJvXvaFwcTZsfIESyV7HWsWmuq8bg4lStQVi8Xbx2eRXqSA271H
 Z01w/xnY+QJipf4fguzopyP0oBMQaB1H6OZBd+hY+d4rjMq3aKe8NA6EGj+AwkVyHiu8
 LtLh3KvGvfc8MFfJzMyElzDQHpgZXcDlS+o76SQUhT9RB0t6Oyk1uOA4TsO4Wj7mEW+Q
 rI8CtXqt5pqJOCQJ1LzsMZwdQznnqBVsSwYLLQk7yKdCWbn/W5oXIEYiZGV4WJ91gSuC
 HiZQ==
X-Gm-Message-State: AOJu0YxT4/UnaUW1jjOICna0sdMP1FauG7DLq0/dgrDXX4PqvQx7f7uE
 vcZxKcssO9CrIsBYjnHz0mD0vwMihBg4dhq4Icas/J+bHDhPDlqrOXAK2tlFUDRdUb97d0hAIMg
 172dUechyJCuSYqGrfbbtIWKA7BLtFmWGVslaiKGl4jnPNSO64c6O+vBi
X-Gm-Gg: AZuq6aIXS9bnF5OenOvwBZKkkSU5AhvNEpI41B/7jZty4KqeVy4KoBECVUATdPSSCUM
 635DzZlM6W6l9oTIbn7Om6UzRoyVUApzN7GD2kd44VnTa8wKZuPmUfbbf/Lpduk7TiSyeR+F4Bt
 S41sExIHn/hCVFNFunXcHXz7cGJsuJ5tnadHiN8/aff45PHA5XiR/w4A5sM7fNxZFVPoKNa72PB
 /t0ooaWHcZssB4T7bvR9TLuq9WuhoHPu2cs6+FUMBMhoaEzEyC1sk5bpHQxr2aJeVkDVY9vgnd8
 CdK4EEpuvHkuUeSYX5jX1J6k+E03WOiCQh/MTem5T+e4AI732wVdjbCFhZ9P6o4eP7xeTuQSgyX
 O4qaW+MffKHCj/jyV5hJtJJKMXLlJORuFcs/ar3R6FuEK/0g0eej5Zev8y9305YYlJMyINpmWNp
 7i66oPqoM2hIoO8dpUZml/r4/Ymg==
X-Received: by 2002:a05:6000:144f:b0:437:7221:67fd with SMTP id
 ffacd0b85a97d-4377a503c0amr4268996f8f.11.1770730899140; 
 Tue, 10 Feb 2026 05:41:39 -0800 (PST)
X-Received: by 2002:a05:6000:144f:b0:437:7221:67fd with SMTP id
 ffacd0b85a97d-4377a503c0amr4268954f8f.11.1770730898758; 
 Tue, 10 Feb 2026 05:41:38 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43629745f7asm30418576f8f.33.2026.02.10.05.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 05:41:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Bernhard Beschow <shentey@gmail.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] target/i386/mshv: remove unused gpa txl optimization
Date: Tue, 10 Feb 2026 14:41:34 +0100
Message-ID: <20260210134134.918944-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251125120852.250149-1-magnuskulke@linux.microsoft.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


