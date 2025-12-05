Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6614DD32D60
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 14:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRWlg-0003v0-OD; Fri, 05 Dec 2025 09:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuramitsu@ksl.ci.kyutech.ac.jp>)
 id 1vRRKY-0007EM-83
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 03:38:23 -0500
Received: from ns.ksl.ci.kyutech.ac.jp ([131.206.203.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuramitsu@ksl.ci.kyutech.ac.jp>)
 id 1vRRKV-0005MU-CW
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 03:38:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ksl.ci.kyutech.ac.jp;
 s=default; t=1764923890;
 bh=lwj06oigZ47pDB1SVSZbSIgyjSSJjHy8qs4I0eJadZ0=;
 h=Date:To:From:Subject:From;
 b=gSmuh4zJic+NIMih6xLy8gup7fFfCCPf8eLijivJxanJn0AntQw/fQKSI+V/NohW7
 TJGV+3qfwTH/A1DJqAQ+5UCmcjGCk4AYfIY3t+QWiy8nqVXVD0+WEwWFKJyLhV+7As
 VrjXQ3dvQqq6gjB94G+eDekuB7ThNURO92qA1Sm2Ay6cm5gkuICA6lmRW4q8mLuL82
 D9GxoGl5xZd8kQCsph5rAlCsJ16rJgIvISnUrhp1GpzEy36eCBfMwYh9XegKj/jom5
 Zrj1hwx6YNCxHFsmG7do3HDPeh8sPGMuJ0y74lCImBNhYvMJkmUi7M/EHnOj+Qb1MT
 qTHXeitVk7qSw==
Received: from [192.168.0.85] (unknown [192.168.0.85])
 by ns.ksl.ci.kyutech.ac.jp (Postfix) with ESMTPSA id B45173C037D
 for <qemu-devel@nongnu.org>; Fri,  5 Dec 2025 17:38:10 +0900 (JST)
Message-ID: <3d73bcbc-d3f0-4271-9f99-d53fb5a85db6@ksl.ci.kyutech.ac.jp>
Date: Fri, 5 Dec 2025 17:38:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org
From: Shusaku KURAMITSU <kuramitsu@ksl.ci.kyutech.ac.jp>
Subject: tcg: Requesting clarification on return value of prepare_host_addr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=131.206.203.254;
 envelope-from=kuramitsu@ksl.ci.kyutech.ac.jp; helo=ns.ksl.ci.kyutech.ac.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 05 Dec 2025 09:26:41 -0500
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

Hello,


I've noticed a possible discrepancy between the comment and the behavior

of i386's prepare_host_addr (located at tcg/i386/tcg-target.c.inc, line 
2157-2260):


```

/*
  * For softmmu, perform the TLB load and compare.
  * For useronly, perform any required alignment tests.
  * In both cases, return a TCGLabelQemuLdst structure if the slow path
  * is required and fill in @h with the host address for the fast path.
  */
static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
                                            TCGReg addr, MemOpIdx oi, 
bool is_ld)
{
     TCGLabelQemuLdst *ldst = NULL;

...
     if (tcg_use_softmmu) {

...

         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
         ldst->addr_reg = addr;

...

     } else if (a_mask) {
...
     }

     return ldst;
}

```


The code appears to always assign (in case of softmmu) a label to `ldst` 
and return it,

contrary to what the comment suggests (that, "in both cases [of softmmu 
and useronly],

return a TCGLabelQemuLdst structure *if the slow path is required*".)

As I understand it, there is no way to determine, at this point, which 
of the two paths to use;

the generated machine code (see L2233-2237), not the C code here, 
performs the TLB comparison.


I am currently building a modified version of QEMU for my undergraduate 
project, and this is

one of the most complicated code paths I've had to deal with.

I hope this is the right place to ask these kinds of questions, and if 
not, please let me know.


Thanks,


Shusaku KURAMITSU

Dept. of Computer Science and Networks

School of Computer Science and Systems Engineering

Kyushu Institute of Technology, Japan



