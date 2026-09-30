Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42842C9830E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 06:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBoCu-0006QG-0D; Wed, 30 Sep 2026 02:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBoCn-0006PL-Fw
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 02:54:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBoCl-0005JF-LJ
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 02:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790751253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mUiKGSMI7MlDX9brfQ4Jm9enCCMM3KGR+Kg/kgaqZsk=;
 b=df7tS66u0ONOlhN3jS5ndxtQckUNGLR5aWQsa85KMjmgL9VUrkzEGuxvBjr/s0BioeCFkC
 ks6IDEGGP4445r9O+LXUjFNzzob9cPoILfFffYNBXDIjbaeo93ZpQKxYyuIO3GsNAgc+fJ
 0czZhGa6QpcjCoaMU8PinfwTQb3YFEA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-zy1bHV1BP9KGYZeCbqpSLw-1; Wed, 30 Sep 2026 02:54:11 -0400
X-MC-Unique: zy1bHV1BP9KGYZeCbqpSLw-1
X-Mimecast-MFC-AGG-ID: zy1bHV1BP9KGYZeCbqpSLw_1790751251
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a009f82bedso19463055e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 23:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790751250; x=1791356050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mUiKGSMI7MlDX9brfQ4Jm9enCCMM3KGR+Kg/kgaqZsk=;
 b=ToMICrJA+tvzTU20NaF7170WCCj3DwouoiMRiosAdEdGQuOcNBsrKnSuZRLYXMJdvH
 mBJun5aVMpkJkyErK0Dp7mSeaNWEXkN+8D1MawkKC6witdR6xWfmEgTztVFqBteLcxDX
 hy9sGsGsHyGdBJdnzP7Gf6uIXB48WQ7V7Hs3ppvUwhrf+19w466n3PhG1B6Wo3Y9W9h0
 sjsPlX+HBNG1whD6T1FwGuGPvPzNrf4+JHAilxvk6ZfA8u0RS0zvb/NcMxSxnNrwgR0l
 Ky4KUcgIi7oQkwvozqDBGUErxvU1OjXTrLE+pf8GsBRX6NbbUiMpKcokoCHmXqMUZZt/
 EXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790751250; x=1791356050;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mUiKGSMI7MlDX9brfQ4Jm9enCCMM3KGR+Kg/kgaqZsk=;
 b=KDW1A7O3Pu9x6uoxhRuCV3pBlrRhhyLcYHrjoeNLoxYkTjvZ34u7mpHz/W2HFEN4ca
 6nhd49hvztjmBzK2dcwjFBoAh9VE3SLlNbD9yCMEQfEPXPd+X7pheMd6TsR6W7MOSVKZ
 ab7yatc2GqZIYrgyfPxVUyI+3jl8tiB9HzhhTfol093XOAnKEmWYeZsloAbxupYBFqZb
 tvKWWs1TTsFPqJo8UWj+glBdBbaLgpijkdKyJVe7YCi38nevZHiKNpix/ez6l2CO1uxO
 28Ji12a1O/pWd7JtI46+F/SVQQx1dLHc/6BBHYmhT4pQiMJEMALAdwro2gnnhEHetSNs
 qYTQ==
X-Gm-Message-State: AFuF++kbYZ+sySDoI7acYDy3/jWNQzMtsFr2oSmkymkd4BU1Qpkl/Q9E
 l3iHnjX3H8OJn63Tnltmh6PYBg2pOEJhdPiNy/Mn9aEu7LRcTqcU4s7isiS9DW/4URvthDCyqM7
 KBylqauckiDIV05nu7Dx65HA9uV8zOgsheriZpqKDVzzUwh4NpcEu/KuT1FkPyihLz3T4nTxunq
 MtVT83GaXoJ1WlwAIJbdabT30bbfyeXIvTcgz/Tt4/
X-Gm-Gg: AYBFou1R8pArYaAhmSilB+5RGMkZP5eLymzxLlcAZh7k7y5Zem+jMyWTznu3uL4YYyq
 rtjZ9VpZnt15JwjDwLPHsBwqA4676UJPt43KWlPtlqxulZw6LDMlYpQPwEKSvAp/PEL9USXUYo8
 KB+1IhVm0oqU4d1TW+hZJH+L2tPBKSCpARlbbILqjcWadyImHNDGfKvsJdAxTol+X/+a6w5phV2
 gb/ST1ldXdCX9DzTkE6vrzydtK1hsK+wrmXcLY+PhH+svF4xPXJNsTLJvDlwNtHEa6TStDom/iN
 0VlSrq61cHkUQcgXXrYZydTHpBMgVgToFMF3QBI6EjXG5es5y21osLODPGPIc9icFheuIfmFvgn
 5Cwu6AJniWhazfX95ujj132jSJ4053RyOFYQqBYGFi4Q9IakjWSyhKhmrwFNzLQfrSmCxuCzGey
 pFnQiy
X-Received: by 2002:a05:600c:3110:b0:499:8aff:59b6 with SMTP id
 5b1f17b1804b1-4a01b00d761mr5299495e9.14.1790751250665; 
 Tue, 29 Sep 2026 23:54:10 -0700 (PDT)
X-Received: by 2002:a05:600c:3110:b0:499:8aff:59b6 with SMTP id
 5b1f17b1804b1-4a01b00d761mr5297975e9.14.1790751248419; 
 Tue, 29 Sep 2026 23:54:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0175064cfsm28207765e9.15.2026.09.29.23.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 23:54:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Andrey Polivoda <apolivodaa433@gmail.com>
Subject: [PATCH v2 0/3] target/i386/tcg: fix REPScalar with memory operand
Date: Wed, 30 Sep 2026 08:54:03 +0200
Message-ID: <20260930065406.738374-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

By the time validate_vex() runs, e->s2 is not used anymore and
decode->op[2].ot has already been filled in by decode_size().
Commit b7d4ec4832d ("target/i386/tcg: move VEX validation early",
2026-08-26) did the change from decode->op[2].ot to e->s2, but
did not move validate_vex() early enough.  Fix it, which also
allows to implement the VEX.LIG case that is needed for unary
AVX operations.

Paolo

Supersedes: <20260923124749.273446-1-pbonzini@redhat.com>

Paolo Bonzini (3):
  target/i386/tcg: extract validate_cr0_exceptions()
  target/i386/tcg: move validate_vex() before all operand decoding
  target/i386/tcg: clarify return value of decode_insn

 target/i386/tcg/decode-new.c.inc | 63 ++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 24 deletions(-)

-- 
2.55.0


