Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C69D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 11:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSve1-0006fY-Gn; Tue, 09 Dec 2025 06:12:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vSvdo-0006eB-NY
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 06:12:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vSvdk-00056m-VM
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 06:12:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765278736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JdNwes1l8de7rQ5a3m7EPhthaQ8+twlb/WlVqqPLcwU=;
 b=Ly3HfG043NyDHL7IXUc6mVMXnoI0W7Zkf9k08shyj7XI6IdS/h7E56eAu93ynkWfiuWHbe
 eqzILP3cfZmA1UuSNQzjvNCa0HWgwkq2w2Ef8NmqX4se5xaI1Tckg5xvG1r7sA1uBsReTC
 xU6ToaTN/Sc05PCgXCZwImfkDpU22Ds=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-rO_T7ApMMxif39NRpVcsjg-1; Tue,
 09 Dec 2025 06:12:13 -0500
X-MC-Unique: rO_T7ApMMxif39NRpVcsjg-1
X-Mimecast-MFC-AGG-ID: rO_T7ApMMxif39NRpVcsjg_1765278732
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A88D195606B; Tue,  9 Dec 2025 11:12:12 +0000 (UTC)
Received: from localhost (dhcp-192-223.str.redhat.com [10.33.192.223])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29CC519560AD; Tue,  9 Dec 2025 11:12:10 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org, sebott@redhat.com
Cc: maz@kernel.org
Subject: Re: [PATCH 1/3] scripts: introduce
 scripts/update-aarch64-sysreg-code.py
In-Reply-To: <20251208163751.611186-2-eric.auger@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20251208163751.611186-1-eric.auger@redhat.com>
 <20251208163751.611186-2-eric.auger@redhat.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Tue, 09 Dec 2025 12:12:08 +0100
Message-ID: <878qfbrjsn.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 08 2025, Eric Auger <eric.auger@redhat.com> wrote:

> Introduce a script that takes as input the Registers.json file
> delivered in the AARCHMRS Features Model downloadable from the
> Arm Developer A-Profile Architecture Exploration Tools page:
> https://developer.arm.com/Architectures/A-Profile%20Architecture#Downloads
> and outputs the list of ID regs in target/arm/cpu-sysregs.h.inc
> under the form of DEF(<name>, <op0>, <op1>, <crn>, <crm>, <op2>).
>
> We only care about IDregs with opcodes satisfying:
> op0 = 3, op1 within [0, 3], crn = 0, crm within [0, 7], op2 within [0, 7]
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
>
> This was tested with https://developer.arm.com/-/cdn-downloads/permalink/Exploration-Tools-OS-Machine-Readable-Data/AARCHMRS_BSD/AARCHMRS_OPENSOURCE_A_profile_FAT-2025-09_ASL0.tar.gz
>
> Discussion about undesired generated regs can be found in
> https://lore.kernel.org/all/CAFEAcA9OXi4v+hdBMamQv85HYp2EqxOA5=nfsdZ5E3nf8RP_pw@mail.gmail.com/
> ---
>  scripts/update-aarch64-sysreg-code.py | 133 ++++++++++++++++++++++++++
>  1 file changed, 133 insertions(+)
>  create mode 100755 scripts/update-aarch64-sysreg-code.py
>
> diff --git a/scripts/update-aarch64-sysreg-code.py b/scripts/update-aarch64-sysreg-code.py
> new file mode 100755
> index 0000000000..c7b31035d1
> --- /dev/null
> +++ b/scripts/update-aarch64-sysreg-code.py

(...)

> +if __name__ == "__main__":
> +    # Single arg expectedr: the path to the Registers.json file
> +    if len(sys.argv) < 2:
> +        print("Usage: scripts/update-aarch64-sysreg-code.py <path_to_registers_json>")
> +        sys.exit(1)
> +    else:
> +        json_file_path = sys.argv[1]
> +
> +    extracted_registers = extract_idregs_from_registers_json(json_file_path)
> +
> +    if extracted_registers:
> +        output_list = extracted_registers.items()
> +
> +        # Sort by register name
> +        sorted_output = sorted(output_list, key=lambda item: item[0])
> +
> +        # format lines as DEF(<name>, <op0>, <op1>, <crn>, <crm>, <op2>)
> +        final_output = ""
> +        for reg_name, encoding in sorted_output:
> +            reformatted_encoding = encoding.replace(" ", ", ")
> +            final_output += f"DEF({reg_name}, {reformatted_encoding})\n"
> +
> +        with open("target/arm/cpu-sysregs.h.inc", 'w') as f:
> +            f.write("/* SPDX-License-Identifier: BSD-3-Clause */\n\n")
> +            f.write("/* This file is autogenerated by ")
> +            f.write("scripts/update-aarch64-sysreg-code.py */\n\n")

I'm wondering if there is an easy way to log the version of the json
file this has been generated against. If not, putting the information
into the commit message when updating is probably sufficient.

> +            f.write(final_output)
> +        print(f"updated target/arm/cpu-sysregs.h.inc")


