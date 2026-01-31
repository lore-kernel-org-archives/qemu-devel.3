Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABFFE7C6EF
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Jan 2026 22:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmJ4k-0007v3-J4; Sat, 31 Jan 2026 17:04:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1vmJ4c-0007tc-Go
 for qemu-devel@nongnu.org; Sat, 31 Jan 2026 17:04:12 -0500
Received: from iguana.tulip.relay.mailchannels.net ([23.83.218.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1vmJ4a-0005Kh-Bq
 for qemu-devel@nongnu.org; Sat, 31 Jan 2026 17:04:10 -0500
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 374858C2608;
 Sat, 31 Jan 2026 22:04:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a203.dreamhost.com
 (100-113-181-83.trex-nlb.outbound.svc.cluster.local [100.113.181.83])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id C66B78C2535;
 Sat, 31 Jan 2026 22:03:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
 t=1769897037;
 b=f2+PQ6kEJ1bfffF+A1us45rp8n5HjS7JFHeORNQ9JWsGqd+d6CrlPSNh+r3GLbJcJqs/mb
 +bIizNaIU7x0fglcutvmx7F/mTPGszlApKCevNZ3QRuSEpgBXV0uZhFY8nz3uj/18PviPu
 PhCYYnzJfcKiKmTiW4/yVRLNXrzV49HVKPeWWVWaWlH6Z4zQL+GJQ71LOxUYMAh4flBFvV
 ZGq/bpD0Ee0Twkw7ysKUPa4wB067AxdDeosEGzy5Fior5iKB3j4RpBfsS+hq5OX+fS1X4p
 KNb+C31GYCZwx40D/aPpy/mdIjNm4x6P4Wna2g4d3qYuFFuWTP1hTFdP/ik72A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1769897037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=fsAC9o/XOfEOIRiP2or7mUgf0ozZe85aO9/HABHRwlg=;
 b=M9Qa21V37OYt9xH9Wwkgnpu81KLk7/v+CpNfAlzugzINOoX2fTVdEYeRM0GlH5Mo+6kC7H
 pvT4pnzRjbCo//BO2yQi42yq58SlHjwSZ0M3ylxj7PE0KlkwNPie5W3zEIzqbLOJeg7Rlp
 l3agB/l3HY6UY3sqrg1uV41anTccq/KydT5r6dML0xUXuZPtTvYVStuqN/XwIFMA3OJEK5
 cHDA5XIVA0wTfhC7x6IvMaFuxn5plGeRa6F9CG4umiqQQqTmKegUjKUp/WWGtLSPYymDBc
 apv6TPKIz+cUdA2bs0TAXK0JtTOUejpswYkiM8AqLP7r7UbgKO1CnY8RKNhtGA==
ARC-Authentication-Results: i=1; rspamd-c758cdf4d-pq422;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Slimy-Invention: 606121e623dc0d96_1769897040088_360769943
X-MC-Loop-Signature: 1769897040088:1666385055
X-MC-Ingress-Time: 1769897040087
Received: from pdx1-sub0-mail-a203.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.113.181.83 (trex/7.1.3); Sat, 31 Jan 2026 22:04:00 +0000
Received: from [IPV6:2607:fb90:fa04:46bc:1ae7:74e8:4c3b:a3a4] (unknown
 [172.58.14.52])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: rob@landley.net)
 by pdx1-sub0-mail-a203.dreamhost.com (Postfix) with ESMTPSA id 4f3RjS6gjwz4D; 
 Sat, 31 Jan 2026 14:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
 s=dreamhost; t=1769897037;
 bh=fsAC9o/XOfEOIRiP2or7mUgf0ozZe85aO9/HABHRwlg=;
 h=Content-Type:Date:Subject:From:To:Cc;
 b=cUSRgCd4iUQllU9GqUnD3D8mSM7NvH0Ls3y3jzWl7WAnNNQuclbPpxjM2hfmuoghy
 Q9CFe4XtAGbWQ0reeU0tzHCj0gmmEYdPcRSc+bgAqaMU6zu7hf1qFx15lCHujK0A95
 9xYW8uY20tIAXFj8iJFHKuv5VVASUF0TeBaGiYQik6wf0oWT8zn/NdpOFai1ghYOrq
 Qx19jY9Qr19F4Hk0QmukrVWGikDUHqsjK87LO4esckP7K2kBFQQ7Km7VDLpIH4BnK2
 9DUgWt4NoVi9jjXS0/DB3gNjGxqZ5Lt1sxL5vlqXui04H7VBkFZTLJx2+Pi+rdL09P
 9noxfczZO6t+w==
Content-Type: multipart/mixed; boundary="------------BAwZr5QWaIVEu09SFmddxMGn"
Message-ID: <fc84475b-52de-4247-9f6f-0212a8b4d860@landley.net>
Date: Sat, 31 Jan 2026 16:03:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 01/13] hw/sh4/r2d: Bail out early if user request
 invalid RAM size
From: Rob Landley <rob@landley.net>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 qemu-devel@nongnu.org, Thorsten Glaser <tg@debian.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Magnus Damm <magnus.damm@gmail.com>
References: <20251124095109.66091-1-philmd@linaro.org>
 <20251124095109.66091-2-philmd@linaro.org>
 <a841c041-30c2-471c-81bc-f0f4576cb772@landley.net>
 <f189995e-09f7-456d-b860-ee6a3dc8fc49@landley.net>
 <9334f855-8e54-0fa3-a2f9-604f72012ace@eik.bme.hu>
 <2446284b-b76c-4335-929d-eeef8ed0c6cc@landley.net>
 <98c1c422-b58b-4850-9b5d-f71e2ad69278@landley.net>
Content-Language: en-US
In-Reply-To: <98c1c422-b58b-4850-9b5d-f71e2ad69278@landley.net>
Received-SPF: pass client-ip=23.83.218.253; envelope-from=rob@landley.net;
 helo=iguana.tulip.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------BAwZr5QWaIVEu09SFmddxMGn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/26/26 12:26, Rob Landley wrote:
> Right, it looks like if I don't care what the real hardware is doing but 
> just want to mangle the emulation to gimme a native build environment 
> with enough ram to build linux from scratch etc in for the architecture, 
> I can tweak hw/sh4/r2d2.c to have SDRAM_BASE of 0x4100000 and SDRAM_SIZE 
> of 0xbf00000 which gives me ~200 megs, and then in the linux kernel 
> config set CONFIG_MEMORY_START and CONFIG_MEMORY_SIZE to match and I 
> don't even need a kernel patch, just a config change...
> 
> And yes!
...
> $ head /proc/cpuinfo
> machine        : RTS7751R2D
...
> $ head /proc/meminfo
> MemTotal:         188356 kB
> MemFree:          182852 kB
> MemAvailable:     180324 kB
> 
> The kernel and qemu have to agree where the memory base is or the - 
> kernel -initrd and -append can't hand off their blobs (which are 
> relative to the start of the big SRAM block), but it works.

Here's a QEMU patch that Does The Thing, with -m wired up.

Rob
--------------BAwZr5QWaIVEu09SFmddxMGn
Content-Type: text/x-patch; charset=UTF-8;
 name="qemu-system-sh4-moremem.patch"
Content-Disposition: attachment; filename="qemu-system-sh4-moremem.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2h3L3NoNC9yMmQuYyBiL2h3L3NoNC9yMmQuYwppbmRleCBhY2IzZmU3
NWE4Li42Y2FkN2NhYzJjIDEwMDY0NAotLS0gYS9ody9zaDQvcjJkLmMKKysrIGIvaHcvc2g0
L3IyZC5jCkBAIC00OCw5ICs0OCw2IEBACiAjZGVmaW5lIEZMQVNIX0JBU0UgMHgwMDAwMDAw
MAogI2RlZmluZSBGTEFTSF9TSVpFICgxNiAqIE1pQikKIAotI2RlZmluZSBTRFJBTV9CQVNF
IDB4MGMwMDAwMDAgLyogUGh5c2ljYWwgbG9jYXRpb24gb2YgU0RSQU06IEFyZWEgMyAqLwot
I2RlZmluZSBTRFJBTV9TSVpFIDB4MDQwMDAwMDAKLQogI2RlZmluZSBTTTUwMV9WUkFNX1NJ
WkUgMHg4MDAwMDAKIAogI2RlZmluZSBCT09UX1BBUkFNU19PRkZTRVQgMHgwMDEwMDAwCkBA
IC0yMzQsOSArMjMxLDYgQEAgc3RhdGljIHN0cnVjdCBRRU1VX1BBQ0tFRAogCiBzdGF0aWMg
dm9pZCByMmRfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUpCiB7Ci0gICAgY29uc3QgY2hh
ciAqa2VybmVsX2ZpbGVuYW1lID0gbWFjaGluZS0+a2VybmVsX2ZpbGVuYW1lOwotICAgIGNv
bnN0IGNoYXIgKmtlcm5lbF9jbWRsaW5lID0gbWFjaGluZS0+a2VybmVsX2NtZGxpbmU7Ci0g
ICAgY29uc3QgY2hhciAqaW5pdHJkX2ZpbGVuYW1lID0gbWFjaGluZS0+aW5pdHJkX2ZpbGVu
YW1lOwogICAgIE1hY2hpbmVDbGFzcyAqbWMgPSBNQUNISU5FX0dFVF9DTEFTUyhtYWNoaW5l
KTsKICAgICBTdXBlckhDUFUgKmNwdTsKICAgICBDUFVTSDRTdGF0ZSAqZW52OwpAQCAtMjUw
LDYgKzI0NCwxOCBAQCBzdGF0aWMgdm9pZCByMmRfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hp
bmUpCiAgICAgUENJQnVzICpwY2lfYnVzOwogICAgIFVTQkJ1cyAqdXNiX2J1czsKICAgICBy
MmRfZnBnYV90ICpmcGdhOworICAgIHVuc2lnbmVkIHNkcmFtX2Jhc2UsIHNkcmFtX3NpemUg
PSBtYWNoaW5lLT5yYW1fc2l6ZTsKKworICAgIC8qIE1ha2UgPD0gNjQgbWVncyBtZW1vcnkg
Y29tcGF0aWJsZSB3aXRoIG9sZC9kZWZhdWx0IGtlcm5lbHMsIG90aGVyd2lzZQorICAgICAg
IG1vdmUgc3RhcnQgb2Ygc2xvdCAzIHRvIHB1dCBtb3JlIFJBTSBpbiBwcmVjZWRpbmcgaG9s
ZSAoTGludXggLmNvbmZpZworICAgICAgIG11c3QgYWRqdXN0IENPTkZJR19NRU1PUllfU1RB
UlQgYW5kIENPTkZJR19NRU1PUllfU0laRSB0byBtYXRjaC4pICovCisgICAgc2RyYW1fYmFz
ZSA9IDB4YzAwMDAwMDsKKyAgICBpZiAobWFjaGluZS0+cmFtX3NpemU+NjQqTWlCKSBzZHJh
bV9iYXNlIC09IG1hY2hpbmUtPnJhbV9zaXplLTY0Kk1pQjsKKyAgICAvKiBDYXAgbWVtb3J5
IGF0IHNpemUgb2YgYXZhaWxhYmxlIGNvbnRpZ3VvdXMgcGh5c2ljYWwgbWFwcGluZyAqLwor
ICAgIGlmIChtYWNoaW5lLT5yYW1fc2l6ZT4weGJmMDAwMDApIHsKKyAgICAgIHNkcmFtX3Np
emUgPSAweGJmMDAwMDA7CisgICAgICBzZHJhbV9iYXNlID0gMHg0MTAwMDAwOworICAgIH0K
IAogICAgIGNwdSA9IFNVUEVSSF9DUFUoY3B1X2NyZWF0ZShtYWNoaW5lLT5jcHVfdHlwZSkp
OwogICAgIGVudiA9ICZjcHUtPmVudjsKQEAgLTI2MCw4ICsyNjYsOCBAQCBzdGF0aWMgdm9p
ZCByMmRfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUpCiAgICAgcWVtdV9yZWdpc3Rlcl9y
ZXNldChtYWluX2NwdV9yZXNldCwgcmVzZXRfaW5mbyk7CiAKICAgICAvKiBBbGxvY2F0ZSBt
ZW1vcnkgc3BhY2UgKi8KLSAgICBtZW1vcnlfcmVnaW9uX2luaXRfcmFtKHNkcmFtLCBOVUxM
LCAicjJkLnNkcmFtIiwgU0RSQU1fU0laRSwgJmVycm9yX2ZhdGFsKTsKLSAgICBtZW1vcnlf
cmVnaW9uX2FkZF9zdWJyZWdpb24oYWRkcmVzc19zcGFjZV9tZW0sIFNEUkFNX0JBU0UsIHNk
cmFtKTsKKyAgICBtZW1vcnlfcmVnaW9uX2luaXRfcmFtKHNkcmFtLCBOVUxMLCAicjJkLnNk
cmFtIiwgc2RyYW1fc2l6ZSwgJmVycm9yX2ZhdGFsKTsKKyAgICBtZW1vcnlfcmVnaW9uX2Fk
ZF9zdWJyZWdpb24oYWRkcmVzc19zcGFjZV9tZW0sIHNkcmFtX2Jhc2UsIHNkcmFtKTsKICAg
ICAvKiBSZWdpc3RlciBwZXJpcGhlcmFscyAqLwogICAgIHMgPSBzaDc3NTBfaW5pdChjcHUs
IGFkZHJlc3Nfc3BhY2VfbWVtKTsKICAgICBmcGdhID0gcjJkX2ZwZ2FfaW5pdChhZGRyZXNz
X3NwYWNlX21lbSwgMHgwNDAwMDAwMCwgc2g3NzUwX2lybChzKSk7CkBAIC0zMjUsMTUgKzMz
MSwxNiBAQCBzdGF0aWMgdm9pZCByMmRfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUpCiAg
ICAgLyogVG9kbzogcmVnaXN0ZXIgb24gYm9hcmQgcmVnaXN0ZXJzICovCiAgICAgbWVtc2V0
KCZib290X3BhcmFtcywgMCwgc2l6ZW9mKGJvb3RfcGFyYW1zKSk7CiAKLSAgICBpZiAoa2Vy
bmVsX2ZpbGVuYW1lKSB7CisgICAgaWYgKG1hY2hpbmUtPmtlcm5lbF9maWxlbmFtZSkgewog
ICAgICAgICBpbnQga2VybmVsX3NpemU7CiAKLSAgICAgICAga2VybmVsX3NpemUgPSBsb2Fk
X2ltYWdlX3RhcmdwaHlzKGtlcm5lbF9maWxlbmFtZSwKLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBTRFJBTV9CQVNFICsgTElOVVhfTE9BRF9PRkZTRVQsCisg
ICAgICAgIGtlcm5lbF9zaXplID0gbG9hZF9pbWFnZV90YXJncGh5cyhtYWNoaW5lLT5rZXJu
ZWxfZmlsZW5hbWUsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c2RyYW1fYmFzZSArIExJTlVYX0xPQURfT0ZGU0VULAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIElOSVRSRF9MT0FEX09GRlNFVCAtIExJTlVYX0xPQURfT0ZG
U0VULAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5VTEwpOwog
ICAgICAgICBpZiAoa2VybmVsX3NpemUgPCAwKSB7Ci0gICAgICAgICAgICBlcnJvcl9yZXBv
cnQoInFlbXU6IGNvdWxkIG5vdCBsb2FkIGtlcm5lbCAnJXMnIiwga2VybmVsX2ZpbGVuYW1l
KTsKKyAgICAgICAgICAgIGVycm9yX3JlcG9ydCgicWVtdTogY291bGQgbm90IGxvYWQga2Vy
bmVsICclcyciLAorICAgICAgICAgICAgICAgIG1hY2hpbmUtPmtlcm5lbF9maWxlbmFtZSk7
CiAgICAgICAgICAgICBleGl0KDEpOwogICAgICAgICB9CiAKQEAgLTM0MywxOSArMzUwLDIw
IEBAIHN0YXRpYyB2b2lkIHIyZF9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSkKICAgICAg
ICAgYWRkcmVzc19zcGFjZV9zdHcoJmFkZHJlc3Nfc3BhY2VfbWVtb3J5LCBTSDc3NTBfQkNS
MiwgMyA8PCAoMyAqIDIpLAogICAgICAgICAgICAgICAgICAgICAgICAgICBNRU1UWEFUVFJT
X1VOU1BFQ0lGSUVELCBOVUxMKTsgLyogY3MzIDMyYml0ICovCiAgICAgICAgIC8qIFN0YXJ0
IGZyb20gUDIgYXJlYSAqLwotICAgICAgICByZXNldF9pbmZvLT52ZWN0b3IgPSAoU0RSQU1f
QkFTRSArIExJTlVYX0xPQURfT0ZGU0VUKSB8IDB4YTAwMDAwMDA7CisgICAgICAgIHJlc2V0
X2luZm8tPnZlY3RvciA9IChzZHJhbV9iYXNlICsgTElOVVhfTE9BRF9PRkZTRVQpIHwgMHhh
MDAwMDAwMDsKICAgICB9CiAKLSAgICBpZiAoaW5pdHJkX2ZpbGVuYW1lKSB7CisgICAgaWYg
KG1hY2hpbmUtPmluaXRyZF9maWxlbmFtZSkgewogICAgICAgICBpbnQgaW5pdHJkX3NpemU7
CiAKLSAgICAgICAgaW5pdHJkX3NpemUgPSBsb2FkX2ltYWdlX3RhcmdwaHlzKGluaXRyZF9m
aWxlbmFtZSwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNE
UkFNX0JBU0UgKyBJTklUUkRfTE9BRF9PRkZTRVQsCi0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBTRFJBTV9TSVpFIC0gSU5JVFJEX0xPQURfT0ZGU0VULAor
ICAgICAgICBpbml0cmRfc2l6ZSA9IGxvYWRfaW1hZ2VfdGFyZ3BoeXMobWFjaGluZS0+aW5p
dHJkX2ZpbGVuYW1lLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc2RyYW1fYmFzZSArIElOSVRSRF9MT0FEX09GRlNFVCwKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHNkcmFtX3NpemUgLSBJTklUUkRfTE9BRF9PRkZT
RVQsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMKTsK
IAogICAgICAgICBpZiAoaW5pdHJkX3NpemUgPCAwKSB7Ci0gICAgICAgICAgICBlcnJvcl9y
ZXBvcnQoInFlbXU6IGNvdWxkIG5vdCBsb2FkIGluaXRyZCAnJXMnIiwgaW5pdHJkX2ZpbGVu
YW1lKTsKKyAgICAgICAgICAgIGVycm9yX3JlcG9ydCgicWVtdTogY291bGQgbm90IGxvYWQg
aW5pdHJkICclcyciLAorICAgICAgICAgICAgICAgIG1hY2hpbmUtPmluaXRyZF9maWxlbmFt
ZSk7CiAgICAgICAgICAgICBleGl0KDEpOwogICAgICAgICB9CiAKQEAgLTM2NSwxNyArMzcz
LDE3IEBAIHN0YXRpYyB2b2lkIHIyZF9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSkKICAg
ICAgICAgYm9vdF9wYXJhbXMuaW5pdHJkX3NpemUgPSB0c3dhcDMyKGluaXRyZF9zaXplKTsK
ICAgICB9CiAKLSAgICBpZiAoa2VybmVsX2NtZGxpbmUpIHsKKyAgICBpZiAobWFjaGluZS0+
a2VybmVsX2NtZGxpbmUpIHsKICAgICAgICAgLyoKICAgICAgICAgICogSSBzZWUgbm8gZXZp
ZGVuY2UgdGhhdCB0aGlzIC5rZXJuZWxfY21kbGluZSBidWZmZXIgcmVxdWlyZXMKICAgICAg
ICAgICogTlVMLXRlcm1pbmF0aW9uLCBzbyB1c2luZyBzdHJuY3B5IHNob3VsZCBiZSBvay4K
ICAgICAgICAgICovCi0gICAgICAgIHN0cm5jcHkoYm9vdF9wYXJhbXMua2VybmVsX2NtZGxp
bmUsIGtlcm5lbF9jbWRsaW5lLAorICAgICAgICBzdHJuY3B5KGJvb3RfcGFyYW1zLmtlcm5l
bF9jbWRsaW5lLCBtYWNoaW5lLT5rZXJuZWxfY21kbGluZSwKICAgICAgICAgICAgICAgICBz
aXplb2YoYm9vdF9wYXJhbXMua2VybmVsX2NtZGxpbmUpKTsKICAgICB9CiAKICAgICByb21f
YWRkX2Jsb2JfZml4ZWQoImJvb3RfcGFyYW1zIiwgJmJvb3RfcGFyYW1zLCBzaXplb2YoYm9v
dF9wYXJhbXMpLAotICAgICAgICAgICAgICAgICAgICAgICBTRFJBTV9CQVNFICsgQk9PVF9Q
QVJBTVNfT0ZGU0VUKTsKKyAgICAgICAgICAgICAgICAgICAgICAgc2RyYW1fYmFzZSArIEJP
T1RfUEFSQU1TX09GRlNFVCk7CiB9CiAKIHN0YXRpYyB2b2lkIHIyZF9tYWNoaW5lX2luaXQo
TWFjaGluZUNsYXNzICptYykK

--------------BAwZr5QWaIVEu09SFmddxMGn--

