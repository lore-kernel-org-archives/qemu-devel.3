Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C779CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNwU-0002px-JL; Mon, 11 May 2026 06:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMNvR-0002iM-JW
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:32:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMNvH-0003Mm-Jd
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778495496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xXDCo57n1k+zasxlwmTzzC9Se/w0SnyiuHLDZv2kVlQ=;
 b=GgfPlhxVONQtSO3FIr5MEda2DysCSlGgs587EM3URY71fiwC5jedNvxNWRw3vaAUTzIH+4
 R+ZJllZI+I6rhsua85Y++9WKJQ1pY9qgEzE1KqU7eq3fVaLAlyGImsYqL/GI4PIDhHXkam
 ZOjRPMHJ5L0EwRezdWx7VB2Jh6u8zLY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-eHuaRdDQPhOBcOi1bAPMXw-1; Mon,
 11 May 2026 03:24:43 -0400
X-MC-Unique: eHuaRdDQPhOBcOi1bAPMXw-1
X-Mimecast-MFC-AGG-ID: eHuaRdDQPhOBcOi1bAPMXw_1778484282
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 107CB1956080; Mon, 11 May 2026 07:24:42 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7963318004A3; Mon, 11 May 2026 07:24:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/2] tpm_emulator: Reject a buffer size different
 than what was requested
From: marcandre.lureau@redhat.com
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, armenon@redhat.com, 
 philmd@linaro.org
In-Reply-To: <20260430155150.2139517-2-stefanb@linux.ibm.com>
References: <20260430155150.2139517-1-stefanb@linux.ibm.com>
 <20260430155150.2139517-2-stefanb@linux.ibm.com>
Date: Mon, 11 May 2026 11:24:33 +0400
Message-Id: <177848427398.2424105.18249583420678062031.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1432;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=lm0rpY4gkvTRzQJ8xSCTf6lmjzqGLQ4sE8tbvyLrK88=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAYQ0joN5qXGDl++4XvOhCZscqTAQt9elM3AXz
 8xnhqkpwgWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagGENAAKCRDa6OEJdZac
 5eiREACjdBLSxfSGkHepU37B7UgXyRNubCrUXSknZyMwSMGxpqF+2Ej3Dz9+zTLgAruifqlXhyP
 fb2qUZLnpbMuscCl/SADVj4x/0Z/1kku1sfeDmtpY8c0XO7IjQOyGrBd1Yy+PO8LXJmLEq8pZco
 A3OGWEoXd5WFtYzBi+MEhxWZ7IjjIuu9f/pgTX5CxcD6oGdrmyZbs5hP41O8SwjFN0/SbHr7k3q
 MwysjT5tzdTqOSEs4UcCQv0TFG+iV2iz4v8MepgD4emvx4bgpZFMuMLMoTTN5WpFHOSfN3Aintj
 dzwEvl7Xb62yhPcBBIEeq3Nv0BWk9jokHFGrh7RGg4wh9Acr5o5vbifDEB/2EjyvayrnbH7hDsQ
 2TvbJUIBlHYNYylweBjax0qrMDUwwWDfruWLqRxy7pUEECaku+kITr099lKvwUZ814vezn8pXmy
 tEolM7u0eWqgjzrdMDnKiRCtdN6uM4m5KiUcgNMD1WygXrLsFBqxuugYUtrvZPXL55EtgLGv4yG
 D8EvEdRf/1EMEfD9TFCQWWa4Q28K36CUW4+6JTJst5KgtNEJ6U170Q19sN2KL3cIEkrdlwAuq/w
 gx3u6A+PXNAheqOh9iLunNLEJWVhkXdK89LN7bHxNXOKQ9B7QrI1eBHsBS7XFqRPDpT0ALFY1lj
 a0etfJn6qoI/u6w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 30 Apr 2026 15:51:49 +0000, Stefan Berger <stefanb@linux.ibm.com> wrote:
> When the TIS, SPAPR, or CRB frontends negotiate a buffer size with the
> TPM backend, then the tpm_emulator (swtpm) could still adjust this size
> of the buffer to within bounds supported by swtpm+libtpms if the chosen
> size was outside the acceptable range. This could theoretically lead to
> the TPM 2 using a bigger buffer than what was requested and memory
> allocated for. In practice this would not happend since the requested size
> of 4096 bytes for TIS and SPAPR and 3968 bytes for CRB are in the

happen

>
>
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index 75c33d290e7..653989ac0e3 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -387,8 +388,18 @@ static int tpm_emulator_set_buffer_size(TPMBackend *tb,
>          return -1;
>      }
>  
> +    tpm_buffersize = be32_to_cpu(psbs.u.resp.buffersize);
> +    /* Reject different buffer size used by the TPM than what was requested. */
> +    if (wanted_size != 0 && wanted_size != tpm_buffersize) {
> +        error_setg(errp,
> +                   "tpm-emulator: TPM did not accept the requested buffer size "
> +                   "of %zu bytes but adjusted it to %zu bytes\n",

Remove the trailing \n in error_setg() format string.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


