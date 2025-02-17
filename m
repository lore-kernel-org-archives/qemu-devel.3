Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B10C021AA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6p4-0001xB-02; Mon, 17 Feb 2025 14:30:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6os-0001t2-UA
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:20 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6on-0008Gp-Mi
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:17 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2fa8ada6662so8775182a91.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820610; x=1740425410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=L5ExhQvln6oXZEW/Kc2U7uq0OWbyEBz4c5xOUDDB7lw=;
 b=fEV1HgSs9JJj1J73h2TBq8rNLgpWZWKQwnYs4CDBhbWYMahSSVmchrznWOiHBVIY53
 DBGi/ve0japMGUIRkliclsQiMDQKGk+/s7HE56uPT0Q0L+Sc4QMHYgJEPz8iM0WU2P/4
 BlYH0bqDb7jXgBnfSlQeFI+Rayx0ea7CoVi4Y5oyBmphdjGJUBgbf7S0lKF3rHkpjIYZ
 2rZkEfuQ5AMlAlnxoCqlm9hgTGxyQS2mmcdQMegjE4ot64w9tUrJ6Hsu4VHu/JkBCkyk
 eZ7JkfFgA0jivWC15HE3jmo5C1sHCh5qtFybU47t6b6WNvWxFOfm7SD4QlCIjTbdQNH4
 lQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820610; x=1740425410;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L5ExhQvln6oXZEW/Kc2U7uq0OWbyEBz4c5xOUDDB7lw=;
 b=qwj/I60LKw1JMwP54O7m5Nq/0AfuRLfDYgHtQTMHWU9qnJuOm1j/kcgux9GCaW+2jn
 xmXGeVsldNe7lpRhVqqPIq6AQdz7apUROHJEQ4uBt7tyO5Yu3rX3WxUroq4qHb9W09V/
 WHyCCY1LbPFolyLvnk8oM3VX4ncMylfa2RBIHTaeDGGZtOgmsPaOJNKj7FF1pXEg/V2x
 ELSgkF/4OvTFYoDJofJqQCit9T7QIhLJ34dXstqm1IKAvp6gU3WbBTbzgrc4Qu1gIucW
 Q4tGq1neTTvMDe7VkG7V1W76FWr2n22TLvKclXgBahTtGoBdnNNhUNKFp0lm4fzwWc41
 n67Q==
X-Gm-Message-State: AOJu0YzV0aiTvDwtkJKjChaYRpDXaFWayzkWem3MO5DD9sI/UwQg1nXa
 L/5XAkhN/z7leohq5z5VmNUJsb5DXvb9ez1OchSVZqjWusiZ/XCm/UHOxw2AWMR05semhIKq0uB
 U
X-Gm-Gg: ASbGncuBB2+x/vuTfawW4s10Zh2vg29O8Eh8UjhgP/knCq2GcC9/W7zPWxq3UYWNYgP
 bwtfmD+iD1jXtFSMil+n1sf9/Z74aYP4GOOzI5pnbZV1iHr/GAOZyN+G57ErQvUacTo8xychRwZ
 OwRtTrpdvW38RnTLBWH0rD01geShcbf9G0veXqN6FHo2zVfjDbBUHHVuWC0U9S7M9ujFg4ro2ST
 zmB6Moht8KhdzV6kY2+7qbdOVHODek5RgLNeluNF12uTMPFdQe3zTZL8gx/IjbBMI6n0r/m1NZb
 kJAK7viyOa2wFlp1E09lK1eoCHrxXrZCPkaHjnODiH1+cdU=
X-Google-Smtp-Source: AGHT+IECjjinK+Ov8tj7s4v9fnXpEnQx0x5j1GiJxN9fwfDswrO0JuwJCLkoPaxX/NOLnYdGf8q3BA==
X-Received: by 2002:a05:6a00:4b16:b0:732:1eb2:7bf3 with SMTP id
 d2e1a72fcca58-7326190da79mr17118750b3a.21.1739820610388; 
 Mon, 17 Feb 2025 11:30:10 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm4347164b3a.160.2025.02.17.11.30.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:30:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/27] tcg patch queue
Date: Mon, 17 Feb 2025 11:29:41 -0800
Message-ID: <20250217193009.2873875-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

v2: Fix target/loongarch printf formats for vaddr
    Include two more reviewed patches.


r~



