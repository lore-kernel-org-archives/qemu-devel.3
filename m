Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18497D1D893
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 18:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0m18-0000Cm-4f; Tue, 15 Oct 2024 14:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t0m16-0000Bw-6N
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 14:11:32 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t0m13-0002U6-TB
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 14:11:31 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2DFEC1F7F7;
 Tue, 15 Oct 2024 18:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729015886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=8osyUbWeh0Wgm7e1yydG7i7XVdhiugRMRL2YmH+ZvZw=;
 b=iAH1dWFdMGX1CaxGmeQb8QgIbj2/Zo9zm0Xk76brBpkkZw7fTkrfgOUbQf7s2cMGa4A04f
 t6VGe8T5FsQ3IGBRb8KDHCpiDf0ohFo+JxP+tt7OTElZCAxZt0AfC4G0Ls7kMUVp67KNAZ
 F7Q71tFVlF5VmI7G6pC5LWD6p3Zk5EU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729015886;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=8osyUbWeh0Wgm7e1yydG7i7XVdhiugRMRL2YmH+ZvZw=;
 b=+ZttejeIWIvFD87KdKV1CDebRDRlG+0BsumB2LEk69xlONQkZ4H/tfPSRa7dkKGT7ITWoq
 QNX87RRNciek1bDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729015886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=8osyUbWeh0Wgm7e1yydG7i7XVdhiugRMRL2YmH+ZvZw=;
 b=iAH1dWFdMGX1CaxGmeQb8QgIbj2/Zo9zm0Xk76brBpkkZw7fTkrfgOUbQf7s2cMGa4A04f
 t6VGe8T5FsQ3IGBRb8KDHCpiDf0ohFo+JxP+tt7OTElZCAxZt0AfC4G0Ls7kMUVp67KNAZ
 F7Q71tFVlF5VmI7G6pC5LWD6p3Zk5EU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729015886;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=8osyUbWeh0Wgm7e1yydG7i7XVdhiugRMRL2YmH+ZvZw=;
 b=+ZttejeIWIvFD87KdKV1CDebRDRlG+0BsumB2LEk69xlONQkZ4H/tfPSRa7dkKGT7ITWoq
 QNX87RRNciek1bDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A976013A53;
 Tue, 15 Oct 2024 18:11:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id h68gHE2wDmeFRwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 15 Oct 2024 18:11:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.ibm.com>
Subject: tpm-tis-device-swtpm-test timeout
Date: Tue, 15 Oct 2024 15:11:22 -0300
Message-ID: <87jze9qlrp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-3.11 / 50.00]; BAYES_HAM(-1.81)[93.90%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TO_DN_SOME(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Stefan,

I see the tpm-tis-device-swtpm test timing out, could you take a look?

qemu:qtest+qtest-aarch64 / qtest-aarch64/tpm-tis-device-swtpm-test time out (After 60.0 seconds)
135/138 qemu:qtest+qtest-aarch64 /
qtest-aarch64/tpm-tis-device-swtpm-test TIMEOUT 60.01s killed by signal 11 SIGSEGV

(gdb) bt
#0 0x00005654e7ac4872 in tpm_tis_transfer (s=0x5654e7dec570, req=0x5654e7b42410 <tpm_pcrread> "\200\001", req_size=21, rsp=0x7ffd2295ca00 '\377' <repeats 200 times>..., rsp_size=1024) at ../tests/qtest/tpm-tis-util.c:490
#1 0x00005654e7ac1879 in tpm_util_pcrread (s=0x5654e7dec570, tx=0x5654e7ac467a <tpm_tis_transfer>, exp_resp=0x5654e7b42620 <tpm_pcrread_resp> "\200\001", exp_resp_size=63) at ../tests/qtest/tpm-util.c:96
#2 0xffffffffffffffff in ?? ()
...

(gdb) l
485         sts = qtest_readl(s, TIS_REG(0, TPM_TIS_REG_STS));
486         bcount = (sts >> 8) & 0xffff;
487
488         memset(rsp, 0, rsp_size);
489         for (i = 0; i < bcount; i++) {
490             rsp[i] = qtest_readb(s, TIS_REG(0, TPM_TIS_REG_DATA_FIFO));
491         }
492
493         /* relinquish use of locality 0 */
494         qtest_writeb(s, TIS_REG(0, TPM_TIS_REG_ACCESS),
(gdb) p rsp_size
$5 = 1024
(gdb) p bcount
$6 = 65535

Thanks!

