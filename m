Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FDACEACE4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 23:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK2nG-0007k6-IL; Fri, 14 Nov 2025 18:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vK2mC-0007GU-0n
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 18:00:26 -0500
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vK2mA-0004aV-AZ
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 18:00:19 -0500
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-4330eb0f232so15282305ab.0
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 15:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763161216; x=1763766016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i9TvG2oqL1dQLCcfT9sslRfQECluHkcmdOPVWIjcQg8=;
 b=Hy+G0SPyQuWs4vQDKVsqS2yNk2hJU2oLBcm93NF/AoPqFxyZWOhF4uTTXbdPf2FvvT
 HkN4ZufINGX9qEXs0S+PfZlhtCtLBUTB9SzLFWg4VFIs1vm+giRdvcF0lG5eQwWfF5Vc
 DcQ2K+bD1ClwI8zS5wS4uUeqBhdo0cbPvf3Y9Z75N6mBfHQN6a10b/yQ6JPH4INgIZgb
 9WwsAGLIFDN/1zjtxwbS40TeM9Um5+VIryaa4Eb4cyPhN16WH/2QCGgnV+MDJFwz//hd
 5DTshjo+x32/3RSqNvJX+N6k84aOKtQ7kf4gl9BIxkhRUdt6DkBgYpp2hERJpoq/Ywqh
 FwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763161216; x=1763766016;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i9TvG2oqL1dQLCcfT9sslRfQECluHkcmdOPVWIjcQg8=;
 b=hPf035eAglqqA3J7BOyiSCkbbFOPTF2RdDISm3mnJDEEGk/V6XXpAlp2HIzIKp79I0
 MO0BT+U4jPdNpV+zgqUo9UXSoHzDAZOGkJbRfgGsvNkCyGCQhKKqodl4/bq8cFGwoy9L
 ZIDNIel7zV1Ehl4ruIvjHR2R+Kmn+wL2Jb+fRTeqNMf99wuJV7aOdaR2rb2t19hu1bEi
 8Z3yFTq//x5rmPe9rf5jTdPJXOzIe0aUZq8rmKy60NPs18mOI6NM5oY/M0StTjyZUfNR
 L4o3EdVGPMd+fsm7Bf+LPz++r89icrfhdH+pEief6WJDT8ugMvfX9wu28buKrIEZlyKR
 53FA==
X-Gm-Message-State: AOJu0YzBNrOrZ9uzZDfVpMZkWMtxgpXz/sGcsHblitT9Dz7gVDblhci0
 cM1W4R8m4KFFgrq2pFl7CpS2yL8tlUxV1cfAAty4koxLct0f4pLYBEz7RmPgteH1
X-Gm-Gg: ASbGncvUeGB5AaAYCE2oW5NcR2hRkXckXYWDY8s0evgHYJ1X8YSNV13UDdj71aD+bZu
 3wzj6bv0PWd3vwKpfj8wFnRA0zBww+HwLf+ggU1iyEFRlMc7DPna4DDXwsDORns+jYnk1oFcBOQ
 9jIgxIsZoCa5TdV9ygkEh78y0MRHDRQ0sZPMXsfig9J2QDxumTr7o1Xrkd2SvjC7Xo4VVTKqbUa
 y6NXseS8tVkvR7MXNV4rGBxzWXpOxtVieZqRqc/Pm+YKj4iFAEUXj1vECOTtYnoTru6erFu9KCi
 meH9chP25lXeIU8crfynqzjsJ7oYpPPfj6/fhl5AVsmGLzvYar+b5Wq+/iAxEzvE/5DGfph5smc
 vx2Vla9dA3u1V18w6z4NFncBizFaSfWXE2DLzkM67vjEQ7swXRFlsEAPlm4k773Chkx8pMsqSMN
 6DMYvBglEBLU6QYZx20Qnf/o5mK1VbCEZOuM+liwi1X8TXTVFjreynSzKZtx61mXVDnUw/PngsP
 dDK
X-Google-Smtp-Source: AGHT+IGSbxmCq/9qX4A8QnHP9uMocen+85yhvpOqobvInXB3RHTT1uDna7RXfrSmi7OE5DqL1LCfdQ==
X-Received: by 2002:a92:d310:0:b0:434:96ea:ca1b with SMTP id
 e9e14a558f8ab-43496eacc97mr17921465ab.19.1763161215913; 
 Fri, 14 Nov 2025 15:00:15 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-434838c24a1sm35673075ab.15.2025.11.14.15.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 15:00:15 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH 0/4] Clean up end-of-instruction processing
Date: Fri, 14 Nov 2025 16:00:09 -0700
Message-ID: <20251114230013.158098-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The changes to packet processing have made some of the end-of-instruction
processing obsolete.  With the addition of gen_analyze_funcs.py and the
ability to short-circuit a packet commit, we no longer need to "log" the
register writes of each instruction.

Taylor Simpson (4):
  Hexagon (target/hexagon) Remove gen_log_reg_write
  Hexagon (target/hexagon) s/gen_log_pred_write/gen_pred_write
  Hexagon (target/hexagon) s/gen_log_vreg_write/gen_vreg_write
  Hexagon (target/hexagon) s/log_write/gen_write

 target/hexagon/gen_tcg.h                    | 11 ++-
 target/hexagon/genptr.h                     |  3 +-
 target/hexagon/genptr.c                     | 86 +++++++++------------
 target/hexagon/idef-parser/parser-helpers.c |  4 +-
 target/hexagon/README                       | 10 ++-
 target/hexagon/gen_tcg_funcs.py             |  3 +-
 target/hexagon/hex_common.py                | 56 +++++++-------
 7 files changed, 77 insertions(+), 96 deletions(-)

-- 
2.43.0


