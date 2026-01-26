Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFFDC88E42
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 02:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkCDJ-0003Cf-Qq; Sun, 25 Jan 2026 21:20:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vkCDG-0003By-Ek; Sun, 25 Jan 2026 21:20:22 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vkCDD-0007Q3-LK; Sun, 25 Jan 2026 21:20:22 -0500
Received: from [192.168.10.110] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60Q2JUCB043018
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 26 Jan 2026 11:19:58 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=eRpvdCOa3/QO5yNrlJHTH3BcETOXKBqy0zF2nLp+YFg=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1769393998; v=1;
 b=s1VTocUiNxShctW9Mjzt/sYJMQwRSpCA5L9p6i/k7ezCqlAjkIqOaNhTW1wjluka
 jdnox3BM/H9aTQ1AMLAH6Yh92MZHbI/0cVM030A5Ec4jukpxNogHmvWweVjk8ESz
 RScyk2I2SAZ3nYUXfRYHSZjdaGx7fz3q2BTP/iDJiZuhkAIY65ai6L3tHkloDzuV
 eqIBdSkVa5A/FWi3XDS4qmaFYm9UZirlwoqcjv8zG0eokxqubOyEgJqvuKAI4N40
 lsH/Od6a7j6QgkssZ6XEejHs/5RrRZ+F6YJ6L833cSJNzSfyR4iulcKF3YGtpgA/
 m9JP0MpQEHm6yPT7+YK6sw==
Message-ID: <58569f5f-19f0-41c4-a576-1fe62d004202@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 26 Jan 2026 11:19:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] contrib/elf2dmp: Grow PDB URL buffer
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
References: <20260125-nvme-v1-0-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
 <20260125-nvme-v1-1-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
 <ff71da32-360a-4e13-8033-dc461b85915a@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <ff71da32-360a-4e13-8033-dc461b85915a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2026/01/26 1:58, Philippe Mathieu-Daudé wrote:
> On 25/1/26 07:42, Akihiko Odaki wrote:
>> The buffers used to construct a PDB URL overflow when the "age" property
>> is greater than 0xf, so grow it. This also simplifies the logic of the
>> URL construction to use one buffer instead of two to avoid the chore to
>> synchronize the sizes of two buffers.
>>
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---
>>   contrib/elf2dmp/main.c | 27 ++++++++++-----------------
>>   1 file changed, 10 insertions(+), 17 deletions(-)
>>
>> diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
>> index d046a72ae67f..83ddc57dd9ee 100644
>> --- a/contrib/elf2dmp/main.c
>> +++ b/contrib/elf2dmp/main.c
>> @@ -494,18 +494,6 @@ static bool pe_check_pdb_name(uint64_t base, void 
>> *start_addr,
>>       return !strcmp(pdb_name, PDB_NAME);
>>   }
>> -static void pe_get_pdb_symstore_hash(OMFSignatureRSDS *rsds, char *hash)
>> -{
>> -    sprintf(hash, "%.08x%.04x%.04x%.02x%.02x", rsds->guid.a, rsds- 
>> >guid.b,
>> -            rsds->guid.c, rsds->guid.d[0], rsds->guid.d[1]);
>> -    hash += 20;
>> -    for (unsigned int i = 0; i < 6; i++, hash += 2) {
>> -        sprintf(hash, "%.02x", rsds->guid.e[i]);
>> -    }
>> -
>> -    sprintf(hash, "%.01x", rsds->age);
>> -}
>> -
>>   int main(int argc, char *argv[])
>>   {
>>       int err = 1;
>> @@ -517,9 +505,7 @@ int main(int argc, char *argv[])
>>       uint64_t KernBase;
>>       void *nt_start_addr = NULL;
>>       WinDumpHeader64 header;
>> -    char pdb_hash[34];
>> -    char pdb_url[] = SYM_URL_BASE PDB_NAME
>> -        "/0123456789ABCDEF0123456789ABCDEFx/" PDB_NAME;
>> +    char pdb_url[sizeof(SYM_URL_BASE PDB_NAME PDB_NAME) + 42];
>>       struct pdb_reader pdb;
>>       uint64_t KdDebuggerDataBlock;
>>       KDDEBUGGER_DATA64 *kdbg;
>> @@ -583,9 +569,16 @@ int main(int argc, char *argv[])
>>       printf("KernBase = 0x%016"PRIx64", signature is \'%.2s\'\n", 
>> KernBase,
>>               (char *)nt_start_addr);
>> -    pe_get_pdb_symstore_hash(&rsds, pdb_hash);
> 
> I'd rather use g_autofree + g_strdup_printf and drop the _NAME definitions.

g_autofree + g_strdup_printf will work. PDB_NAME is still useful because 
somehow it is repeated twice in the URL.

> 
>> +    sprintf(pdb_url,
>> +            "%s%.08x%.04x%.04x"
>> +            "%.02x%.02x"
>> +            "%.02x%.02x%.02x%.02x%.02x%.02x"
>> +            "%.01x%s",
>> +            SYM_URL_BASE PDB_NAME "/", rsds.guid.a, rsds.guid.b, 
>> rsds.guid.c,
>> +            rsds.guid.d[0], rsds.guid.d[1],
>> +            rsds.guid.e[0], rsds.guid.e[1], rsds.guid.e[2], 
>> rsds.guid.e[3], rsds.guid.e[4], rsds.guid.e[5],
>> +            rsds.age, "/" PDB_NAME);
>> -    sprintf(pdb_url, "%s%s/%s/%s", SYM_URL_BASE, PDB_NAME, pdb_hash, 
>> PDB_NAME);
>>       printf("PDB URL is %s\n", pdb_url);
>>       if (!download_url(PDB_NAME, pdb_url)) {
>>
> 


