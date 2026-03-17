Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A6EFD707A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 11:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2SDb-0004qw-LS; Tue, 17 Mar 2026 07:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w2SDY-0004pV-H4
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 07:04:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w2SDW-0000Zm-3O
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 07:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773745443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=PQJIrAfFeOULAWlFqB99x5fCwLc8IbZeA65L/b01W/XzCqh9oTzThMqIGGwZFh6e/yHk+b
 1W6qdtOJt1XHDScfuYZcj54R9bfw9ZwOwINJTT3hQXGdzatA8hzQ9USfPE1Q6HBqy798J3
 aYiDIL9SvbCBy8hfiHH8VbQ9WKedkvs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-oWRJ6gfIOLiTuEwp-k8EUg-1; Tue, 17 Mar 2026 07:04:02 -0400
X-MC-Unique: oWRJ6gfIOLiTuEwp-k8EUg-1
X-Mimecast-MFC-AGG-ID: oWRJ6gfIOLiTuEwp-k8EUg_1773745441
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4865f728934so3638745e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 04:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773745441; x=1774350241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=R0g+XdkjmYaHvk7Li8S7a8out+LVlO5N46PfXj4HCtDaoRntXjLDnXFoyM6UpIJTS4
 yMdlUttouFPVSA7wwS7gtNkqFNCnzYgyqLzMmbF5Xo0gphDOytjBluV42oO4F9cbaImX
 Uz9UnAHRDJDL+HnjS/nusnhNLgJctFdFR5idr+lIjwpl56dKDh/1zqS5TWsq8JBHnkO/
 ZxNcw4vm4eoXPgHYOGSfr8pDuQQh7jx5GFoaWNsYB2j3m25V/CpUhBnlpx4KGoaw+JZm
 1DlqrLB2fIntj0bbeSPxn1jYghsectdDw4Xq4RcBzp1APfSUxMsCjwF+eBfUoIpLlVPR
 QvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773745441; x=1774350241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=DwPtqk0pXR42KCVSoxvip8GzMPv3lECb228q/9rqLZsi6CFx5/f1INGJd9w1qa4Giy
 oFCnxcKwdbYI0E6KSd3vzXMAbdaOcUEQEFUTMXq32vfp+hT5OTNx+eXi3zbq47tr97KU
 mc6WDfZkCEsZdUOd323KiGlhh5Pu7+P30IP7r12GHONDY8X1i0y/xoqdF2D3/RV7SLWF
 86Uxff7+IFQ3ukBhVic3sNmytlxkhv7SKSR1scjdWnRMdcO1rqT2qPp+7vo5TM4H4JJ3
 RxK2cNi1vY25m4fT0TTAAwjja90If4Ng0GnSR0HsMnoOt5Olnr5G/oFmonU49pIp7+Aa
 /fJQ==
X-Gm-Message-State: AOJu0YxM9Fhpn45EZMSziRxVmexsCJrCxkCGO2+vBfSS0rAW1UMlzJxe
 mm0tvnkLeT3D17v561xtnHXRXM7w2Gx0md9/RaXFA5a38hedVeNMY+cNx3HdhbdjSjyl+3s3hor
 2yXWvC9MrWb0jx0mEc2A1YG8s3AHbu0/3dzJFNyaBtw9PZkTgImZuAuV9
X-Gm-Gg: ATEYQzymSD9XQmqsQTsEm8zdTqMmOJCzEm9Cxbl2h5jhTBODbGRlJ9gTjOH0AMQHO/Q
 a94JGL+uNlcd/ZEkeAggqCTinkaRIF4QB6ioZOaBUc5XxIFWnfrkE4gnhlBOILULhAMwJ6TGXNa
 /ygfCVoHOdmNszY9Cv9FbLjpOu4N3nohiO/rQClmT3iLgdDdVnz3lZlCy2hWAk3wrkurdmZdcme
 X5b+TLtper45dM+EvV5G1RbAstxzvbWf90PRxr12hGxWXXr+o2rY/+XvNStLVAGQq4xoW8WtDMs
 y1H7zSDN4/wEWfu7TpZ0mls1PlWPaEc6XfAc07U9b+Yd433WG/bzPR5A+v4YavYBAq64CioV9O6
 8ENQMql37Xh/gB5Xn8g5qEkfdStDb3keaVOc8TW6Tx9VYoL9mrQbtue5pZ+RiC7upIw4gRIV8uz
 22lRzEIHwCHnIl2J3fODNjWdFHNyA=
X-Received: by 2002:a05:600c:4f54:b0:485:353f:c651 with SMTP id
 5b1f17b1804b1-48556702b4dmr277348485e9.22.1773745441068; 
 Tue, 17 Mar 2026 04:04:01 -0700 (PDT)
X-Received: by 2002:a05:600c:4f54:b0:485:353f:c651 with SMTP id
 5b1f17b1804b1-48556702b4dmr277347695e9.22.1773745440573; 
 Tue, 17 Mar 2026 04:04:00 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557c66583sm120630785e9.21.2026.03.17.04.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 04:03:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, berrange@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] build-sys: use the "run" variable
Date: Tue, 17 Mar 2026 12:03:57 +0100
Message-ID: <20260317110357.796605-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260211103305.3112657-1-marcandre.lureau@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


