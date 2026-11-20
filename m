Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67448606A6B2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 22:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUWvQ-0008U2-9W; Fri, 20 Nov 2026 17:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xUWvO-0008Tg-Mg
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 17:17:42 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xUWvM-00080H-R6
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 17:17:42 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8F15B60E017;
 Fri, 20 Nov 2026 23:17:39 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id t8ZkQlT_v4_4; Fri, 20 Nov 2026 23:17:37 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7344260CCE7; Fri, 20 Nov 2026 23:17:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7142613C28F;
 Fri, 20 Nov 2026 23:17:37 +0100 (CET)
Date: Fri, 20 Nov 2026 23:17:37 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Fam Zheng <fam@euphon.net>, Keith Monahan <keith@techtravels.org>
Subject: Re: [RFC PATCH-for-11.2? v4 11/14] hw/scsi/ncr53c710: Guard SCRIPTS
 reentrancy and cancel requests on soft reset
In-Reply-To: <20261120171235.61325-12-philmd@oss.qualcomm.com>
Message-ID: <353f4998-ef46-4851-ceca-4d31e57765f4@eik.bme.hu>
References: <20261120171235.61325-1-philmd@oss.qualcomm.com>
 <20261120171235.61325-12-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1321249882-1795213057=:80696"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1321249882-1795213057=:80696
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 20 Nov 2026, Philippe Mathieu-Daudé wrote:
> From: Keith Monahan <keith@techtravels.org>
>
> The interpreter guards the reentrancy class behind CVE-2023-0330: a
> completion that fires synchronously while lsi_execute_script is already
> on the stack no longer recurses, and a script that retriggers itself is
> bounded by a recursion depth limit.

I don't understand this sentence above. Does it make sense or could it be 
clarified?

Regards,
BALATON Zoltan

> A guest ISTAT.RST soft reset cancels the connected and any queued
> tagged requests, so a stale s->current cannot dangle into the next
> command and queued requests are not leaked, mirroring the SCNTL1.RST
> bus reset teardown.
>
> Signed-off-by: Keith Monahan <keith@techtravels.org>
> Signed-off-by: Helge Deller <deller@gmx.de>
> AI-used-for: Patch series decomposition (commit splitting and ordering)
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
> hw/scsi/ncr53c710.h |  5 +++++
> hw/scsi/ncr53c710.c | 41 +++++++++++++++++++++++++++++++++++++++--
> 2 files changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/hw/scsi/ncr53c710.h b/hw/scsi/ncr53c710.h
> index 8b5cbfc135e3..9a4816794e1d 100644
> --- a/hw/scsi/ncr53c710.h
> +++ b/hw/scsi/ncr53c710.h
> @@ -101,6 +101,11 @@ typedef struct NCR710State {
>     bool sigp_pending_resume;
>     /* A SCSI continue was deferred to lsi_issue_bh. */
>     bool issue_pending;
> +    /*
> +     * SCRIPTS interpreter recursion depth; always 0 outside
> +     * lsi_execute_script, so it is not migrated.
> +     */
> +    int reentrancy_level;
>     lsi_request *current;
>     /* Disconnected tagged commands awaiting reselection. */
>     QTAILQ_HEAD(, lsi_request) queue;
> diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
> index dfed2f2f9fdd..f75540da7720 100644
> --- a/hw/scsi/ncr53c710.c
> +++ b/hw/scsi/ncr53c710.c
> @@ -103,8 +103,23 @@ static int lsi_id_from_bits(unsigned bits)
>
> void ncr710_soft_reset(NCR710State *s)
> {
> +    lsi_request *p, *p_next;
> +
>     trace_ncr710_reset();
>
> +    /*
> +     * A guest ISTAT.RST soft reset can land with commands still in flight.
> +     * Cancel them so no stale pointer survives the reset.
> +     */
> +    if (s->current && s->current->req) {
> +        scsi_req_cancel(s->current->req);
> +    }
> +    QTAILQ_FOREACH_SAFE(p, &s->queue, next, p_next) {
> +        if (p->req) {
> +            scsi_req_cancel(p->req);
> +        }
> +    }
> +
>     s->carry = 0;
>     s->msg_action = LSI_MSG_ACTION_COMMAND;
>     s->msg_len = 0;
> @@ -114,6 +129,11 @@ void ncr710_soft_reset(NCR710State *s)
>     s->command_complete = 0;
>     s->script_running = false;
>     s->sigp_pending_resume = false;
> +    /*
> +     * Do not reset reentrancy_level here.  A SCRIPTS driven soft reset can run
> +     * while lsi_execute_script frames are still on the stack; those frames
> +     * decrement the counter as they unwind.
> +     */
>
>     s->scntl0 = 0xc0;       /* full arbitration */
>     s->scntl1 = 0;
> @@ -257,6 +277,16 @@ static int lsi_bad_phase(NCR710State *s, int new_phase)
> static void lsi_resume_script(NCR710State *s)
> {
>     trace_ncr710_resume_script(s->waiting);
> +    if (s->reentrancy_level > 0) {
> +        /*
> +         * A completion fired synchronously while the SCRIPTS interpreter is
> +         * already on the stack.  Do not recurse: release the wait so the outer
> +         * loop continues to the next instruction, which the completion has
> +         * already armed.
> +         */
> +        s->waiting = LSI_NOWAIT;
> +        return;
> +    }
>     if (s->waiting != LSI_DMA_SCRIPTS) {
>         s->waiting = LSI_NOWAIT;
>         lsi_execute_script(s);
> @@ -857,13 +887,18 @@ static void lsi_execute_script(NCR710State *s)
>         s->waiting = LSI_NOWAIT;
>     }
>
> +    s->reentrancy_level++;
>     s->script_running = true;
> again:
> -    /* Yield to the CPU after LSI_MAX_INSN instructions. */
> -    if (++insn_processed > LSI_MAX_INSN) {
> +    /*
> +     * Yield to the CPU after LSI_MAX_INSN instructions, and guard against a
> +     * script that retriggers itself (CVE-2023-0330).
> +     */
> +    if (++insn_processed > LSI_MAX_INSN || s->reentrancy_level > 8) {
>         trace_ncr710_script_yield(insn_processed);
>         s->waiting = LSI_WAIT_SCRIPTS;
>         lsi_scripts_timer_start(s);
> +        s->reentrancy_level--;
>         return;
>     }
>
> @@ -1209,6 +1244,8 @@ again:
>             goto again;
>         }
>     }
> +
> +    s->reentrancy_level--;
> }
>
> static uint8_t lsi_reg_readb(NCR710State *s, int offset)
>
--3866299591-1321249882-1795213057=:80696--

