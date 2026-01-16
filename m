Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B971AD4899A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 12:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgj8D-00028B-1t; Fri, 16 Jan 2026 07:40:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgj7b-00021K-Ma
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:40:12 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgj7Z-0004fd-3L
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:40:10 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-432d2670932so1634962f8f.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 04:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768567207; x=1769172007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3uqa3yy6jOWl6xd50zEi7jWQQ+5qpcwUzSxH9gQWYcY=;
 b=LXsgjeogmIgJJO/F7BMaI5bktot2OkT2xdXnE8tsVoUOuQxI4LK0AHf9DqNY44MS1U
 BMerUsPUl8VIbO2U4qLYPDOPqR1RG06T+5JX5T8AGmc6Xq67j9HQWHKk3XRM8GGgZtnq
 t6VX48JcNQYfWxgcXRzSWowuFng6ttEmQLPjF26iIhWjMPdvAdXZhvsH55cUut5Im9kA
 UCXmzuqgCsaCm/WY/c0YaqG4rSQMx2Nj/UDL5Qp1/qKBqpt/WF/YWqd3hvf3JEsTY5h7
 7t0CrUC4/PMaykPNGkGPzMa7inDxvSCXU+IjPNdloQWIKS4Lapvo7Fhh7RIK+XVK4Nk1
 Ae+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768567207; x=1769172007;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3uqa3yy6jOWl6xd50zEi7jWQQ+5qpcwUzSxH9gQWYcY=;
 b=XTzQtxiBGiZp3Mxd0G20rDU06mCGE8sP2kQIg9kuvRNl3rJO9yhDtJAG97w5khhHjL
 IZg7BloVGSgMdDVzE4gPTFR5U0ZMnXyVnnGrrcB4rxTtNNGH6CYjK2ZKxbD3MegBzDtt
 bJRNrz75U5YDszY9q6YAyMISQTEbjZA8ZxVfPH/6STghSNJneVjh2gcPZmXzbc4kqWJS
 u5Rx2QntS49y0IYXaPFKSWzbBuSCZiaYv7vt1QfNCBa58oiW/NzfaziWAEKE+G7IPJMw
 fCMT72wpNJ/u9eMnejRRadQaCJxOQJtu7iBPLKQFtlZLnS+iYWOgKNjHdiBYSsIgtsRC
 871w==
X-Gm-Message-State: AOJu0Yz0KhAnBvjvUyJSxmGU+MhgNyENWDl3GtPA6k7O1OppsJoA/GNo
 r0ipDxhcRuIykDPCg60MMppzj51WmYTkhVqqgTnZGhYDuy1RJtL92TXlVa+5kHskOxdy1QD5BI6
 dtC7d
X-Gm-Gg: AY/fxX54NCfNaQa8voOR7ksvBcXJF3WgOhidM21xkiYp08vlB33rQPGPff3o+kcFT/P
 p12arEq31m3efc71BRIg4t2V4SPdXHtQR8sTEnufDQFOaEydmbH6sTZ9nFZcdQHnsysqQ99sALk
 FKvqoF3XDR8NsEa4m/ByKiI/V0cb67YaE90Z/3UYh+Xfj9Bv0+BHf2LT8vEXXsOHX3Rx1ATtmwP
 K/fXElnq2KHJ3cisaFdfaYqIU85X1OxwBRFb/Y1UyGmvWhjmJHN5DMsF7U5reWjKEgfWhKi1cSG
 ulNhx6Upoi9v8Fr9PguvEK7nn8b0p21HPG9l2iTY6Wl/a6jf0MRDsQOnp42DwnOI+Mypurl4a5M
 28orIvpeq8t3yWtIXTl0GDmFUkf1mhxAYrFRb7NM2uIkAGctEkkb8xU9cDmIni+j2BUnPEgccFu
 XHA89ItQua6qjbNZSF0ikqw4OZ4l/77QWmU+N5Zo11IWRlDwAErSM4xApR8IJAjPXa1LV/NUDgo
 5RUC4C1PHUlSD4ROfJX3ZntUugukIL3RyJMTOArbpuBlKGn/N8Ysuaw
X-Received: by 2002:a05:6000:2512:b0:430:fa9a:74d with SMTP id
 ffacd0b85a97d-43569998efdmr3454760f8f.24.1768567207255; 
 Fri, 16 Jan 2026 04:40:07 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992c6f2sm5192566f8f.19.2026.01.16.04.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 04:40:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 0/6] scripts/clean-includes: Misc improvements
Date: Fri, 16 Jan 2026 12:39:59 +0000
Message-ID: <20260116124005.925382-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

This is v2 of a series I sent last year:
https://patchew.org/QEMU/20251104160943.751997-1-peter.maydell@linaro.org/

which make clean-includes a bit easier to use and maintain,
and update the exclude list.

All these patches have been reviewed except patch 5; the change
there is to make the command line given in the generated git
commit message properly shell-quote the arguments.

I also have some patches which I have produced by running this
updated script, but I'll post those separately. The exclude list
as updated by this series is enough to make all the changes the
script suggests be correct ones, with the possible exception of
hw/virtio/cbor-helpers.c, where I'm waiting to find out if we
should make the change or put it on the exclude list.

thanks
-- PMM

Peter Maydell (6):
  scripts/clean-includes: Allow directories on command line
  scripts/clean-includes: Remove outdated comment
  scripts/clean-includes: Make ignore-regexes one per line
  scripts/clean-includes: Do all our exclusions with REGEXFILE
  scripts/clean-includes: Give the args in git commit messages
  scripts/clean-includes: Update exclude list

 scripts/clean-includes | 105 +++++++++++++++++++++++++++++------------
 1 file changed, 74 insertions(+), 31 deletions(-)

-- 
2.47.3


