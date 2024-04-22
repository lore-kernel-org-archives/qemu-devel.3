Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F413C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 11:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rys2O-0006rh-Te; Mon, 22 Apr 2024 07:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1rys2M-0006rJ-KU; Mon, 22 Apr 2024 07:40:42 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1rys2K-0001vU-MI; Mon, 22 Apr 2024 07:40:42 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com AECCEC0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1713786036;
 bh=EuuIssokjsKxqeKF8jpo5+XooGzJXGYbZRbkLXCQAUs=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=kZU+tGee/oI/3HSLtOKGgZ3JQ2cTzzTEsmi1BYCmuHK54Tn8UAXfOQ8oRh2ogSKgu
 k7VDxkOKJIFhdg0Py/0R0obTGS/dfpFCPeD0L8ceqiPNoSm59rikITktAdFvbD5wNt
 DfC7jbIhRqBeX2Uw2081gUuoIJCN9kOB4KxeVbt1GzFm3Snm1do73frscAZRgCF7kn
 te1zMLmLBAKw7LMDWcBvTCf7z/Vyso3xHrM/j8EwSlIGMcIZROG0JOjOyHNx5f3j08
 ZXnSoDJ4bd86uAyEi6t3nwpNuZe755fDm5271tHjcGnk72EptOBz7aqSc6gs/Y60dP
 NNrt0ZpeYVB+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1713786036;
 bh=EuuIssokjsKxqeKF8jpo5+XooGzJXGYbZRbkLXCQAUs=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=u8e40+Ob7izYrYzkdoWFhiHIF7g/lriFD/rCo5M1Rubh+oEAlbc+tRUs+mz4gxAOa
 EkMNwdYKtkNs01cmkUodLbfQjhvt6KpRSLU+X+FDJ5CchSaeqxPdPnaK502OPHGqH5
 Fbl/KvWgX4FWVZCoCax/dycfufxOnhxJISBtE2tZx62IssYUYwx4KNKB04+wBxhZE0
 /M1UMPPzwS8AGn9RCYLQ2jZiWLpSNn2xiANgB2Ot0OsZ2LELWT8Jzu9bT541Mphdar
 yyIzj55rQSC7dwpROnKkM6asiutdkomP19Pn4c5/toQ6arYBSo4ngJo36rAbav+SXo
 4ZoMZbf09u/EQ==
Message-ID: <ecbda674-791d-4064-b48e-398cbf34b603@syntacore.com>
Date: Mon, 22 Apr 2024 14:40:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] target/riscv/kvm/kvm-cpu.c: kvm_riscv_handle_sbi()
 fail with vendor-specific sbi.
To: <ajones@ventanamicro.com>
CC: <alistair.francis@wdc.com>, <alistair23@gmail.com>,
 <apatel@ventanamicro.com>, <bin.meng@windriver.com>,
 <dbarboza@ventanamicro.com>, <liwei1518@gmail.com>, <palmer@dabbelt.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>,
 <zhiwei_liu@linux.alibaba.com>
References: <20240422-e78b28f00a168518c5d4937a@orel>
 <20240422112437.11079-1-alexei.filippov@syntacore.com>
Content-Language: en-US
From: Aleksei Filippov <alexei.filippov@syntacore.com>
Organization: Syntacore
In-Reply-To: <20240422112437.11079-1-alexei.filippov@syntacore.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=alexei.filippov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SORTED_RECIPS=2.499,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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



On 22.04.2024 14:24, Alexei Filippov wrote:
> kvm_riscv_handle_sbi() may return not supported return code to not
> trigger qemu abort with vendor-specific sbi.
> 
> Add new error path to provide proper error in case of
> qemu_chr_fe_read_all() may not return sizeof(ch).
> 
> Added SBI related return code's defines.
> 
> Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
> ---
>   target/riscv/kvm/kvm-cpu.c         | 9 +++++----
>   target/riscv/sbi_ecall_interface.h | 1 +
>   2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index aeca1e3e83..5bb7b74d03 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1173,17 +1173,18 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
>           ret = qemu_chr_fe_read_all(serial_hd(0)->be, &ch, sizeof(ch));
>           if (ret == sizeof(ch)) {
>               run->riscv_sbi.ret[0] = ch;
> -        } else {
> +            ret = 0;
> +        } else if (ret == 0) {
>               run->riscv_sbi.ret[0] = SBI_ERR_FAILURE;
> +        } else {
> +            ret = -1;
>           }
> -        ret = 0;
>           break;
>       default:
>           qemu_log_mask(LOG_UNIMP,
> -                      "%s: un-handled SBI EXIT, specific reasons is %lu\n",
> +                      "%s: Unhandled SBI exit with extension-id %lu\n"
>                         __func__, run->riscv_sbi.extension_id);
>           run->riscv_sbi.ret[0] = SBI_ERR_NOT_SUPPORTED;
> -        ret = 0;
>           break;
>       }
>       return ret;
> diff --git a/target/riscv/sbi_ecall_interface.h b/target/riscv/sbi_ecall_interface.h
> index 0279e92a36..a2e21d9b8c 100644
> --- a/target/riscv/sbi_ecall_interface.h
> +++ b/target/riscv/sbi_ecall_interface.h
> @@ -79,5 +79,6 @@
>   #define SBI_ERR_ALREADY_AVAILABLE   -6
>   #define SBI_ERR_ALREADY_STARTED     -7
>   #define SBI_ERR_ALREADY_STOPPED     -8
> +#define SBI_ERR_NO_SHMEM            -9
>   
>   #endif

Oh, my bad, wrong patch. Will resend properly.
-- 
Sincerely,
Aleksei Filippov

