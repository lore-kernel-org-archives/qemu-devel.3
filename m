Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775AFF34C65
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 16:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCK3c-00031S-9i; Mon, 13 Apr 2026 12:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wCK3W-00030w-NH
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 12:22:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wCK3R-0006sR-LU
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 12:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776097348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=QhfTTRs8lfjSyagX0+ybDV+F2kpS3a1o/LMlgMHBy6P9Mlkj/+bgZ/cxOuM/eHIxWxafc2
 GReEMiXvdF+EdnamdIUPeGMzugd9lTtMZZ2KVDDr2wTfbS43DBUc/LhQ/O8jwm+X1LtCBw
 yykirvjOo+p3SbhZgmYuEy1HXK33npo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-YevMDonHO2OSIqt7o0MMiw-1; Mon, 13 Apr 2026 12:22:26 -0400
X-MC-Unique: YevMDonHO2OSIqt7o0MMiw-1
X-Mimecast-MFC-AGG-ID: YevMDonHO2OSIqt7o0MMiw_1776097345
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-488ba2f4094so29356715e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 09:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776097345; x=1776702145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=ZIBsvyKaTQSqn+M58CTlC4lyOU9oXf905L1iZrDzfEylEkZEXPDUUIgwmQl1l+zoB+
 31hMvQE3uX+dNlYB3BGTMQxGWlejoa7ipyemmmsO3vgj5HjmgUrGACofSa1CnHwY8k01
 7H9ca5dBYYxjvRgGiBWJpOlCgI/YBJkEutO7dhYv+nIoVQQKI9b5s6GG/qyJCTmtR8q+
 0QuzyrmZ3wGinmNXp1cMyoGLwuaFklD9ecdZF2CTRWDcOJYgV0vNrBQe2R0WTMr/QRYc
 2brRfVAlN+QZgceMqkQ22VwW06WPV+pR/uKaaWcT2MimNoIzLrr6GpYhmGdU8YRPiI2y
 amJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776097345; x=1776702145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Ca+yXmVJt6sdhpOI00ZVRlvXC1lBu7Msvdi48i49jBfvG5drbO/VyX+9my6YKYweP7
 goYewNz03O+XHWsWVwUaQ7iyBUJqfq0+DCjrq7AW6PnYrFXWOPhW9LNZhjlrogy5usQG
 t8jdKNxmKMsAQDxEz4nu87EUTzuFrTxJV/R0hrBRvkXXftYDiaE8bDtbNZVo8aDGl9K7
 Fpa76HNFOMFET4zo6J5aFOLP5jUZ8qioF/B3pF571BFh0eUznG/peDfukTmVar7brKd1
 Ju39aE89XgDdB9gOM9N1+S8ZHcT0G7u0OCfnTzJDWaeRf60q1dkViAG3EkofEHEgvAPK
 uK9A==
X-Gm-Message-State: AOJu0Yz1J1/nyy6ayhq8/zl40cLbwFjpHoNSVXOO/sW7IT6Wdokquf+L
 OBA6/QMQdSzEDYdFhTvsiBgYgFd/HWcs6fay8fsCeDJFW09n778kUsxZsAiacSRatj52hDAz3ru
 +nT27U/BhCUgL8QBzOnL02yvmQxIGn8mWlrV5bMQurXvEt5zhBmCPdunB
X-Gm-Gg: AeBDiev1a0KacyXxboefCtelRtwk+GhGqyJhISabhD8/c2ciBZ/0ou0rHgPSaYU+BOR
 IQXwBHlqKF+kSITlbMfMOzNwrlRej3eCXu0TSX0olT3fp3YXLnAHFJ32Q8IBaohV6f9vfpr7Wnc
 FMq/qAuopGJYESd6qFRIxYr5AteaeT+SEPuZ1UO5NKfuiAsj9XeajYBRK12+ef/pxGOmsZAw74d
 wa39h3w50UTxt6bBF+oD+zTia6ntbtTmih1koSemBdbRSBwZki84Lk6QP+1jtC1Ow8Btb0ZAWK/
 kRNs5rm939lJdDqMLrDU80UYsYHjRtid5xGXHaA9Tafqaf/U50J2DwmW7k+aeck5Jv0nhOpiCPe
 /zhBW33ebe1dPea8bgFhjjuAiGzuZNhTUlyxvZCc76tnxCJzNhq08kN6fjutOuGtVNBLJNZvx5l
 6SMcLaGBf/mytAdSFlo4sv8TcF
X-Received: by 2002:a05:600c:8710:b0:485:3abe:ab86 with SMTP id
 5b1f17b1804b1-488d67bbd1dmr207840105e9.4.1776097344975; 
 Mon, 13 Apr 2026 09:22:24 -0700 (PDT)
X-Received: by 2002:a05:600c:8710:b0:485:3abe:ab86 with SMTP id
 5b1f17b1804b1-488d67bbd1dmr207839785e9.4.1776097344582; 
 Mon, 13 Apr 2026 09:22:24 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d53808b2sm378656025e9.11.2026.04.13.09.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 09:22:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Simon Scherer <scherer.simon89@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org
Subject: Re: [PATCH] target/i386: fix missing PF_INSTR in SIGSEGV context
Date: Mon, 13 Apr 2026 14:57:10 +0200
Message-ID: <20260413125710.251266-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413115622.160212-1-scherer.simon89@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.54, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


