Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C095CD37B5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNrZ-0001HD-7I; Mon, 11 May 2026 06:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMNrM-00019N-B6
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:27:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMNrK-0000kH-KW
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778495253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KwGpzF9EDm5Qo5ysheH/t9FYcGz+HRJvpINIm299ktE=;
 b=fznj3sF+Sl7fUvzEGudn+rfSZCLz839Fv2ZfaVJiN9GVG1+Ga9QYp3LeTGYV/a6kBHK0J7
 5OwWTyCxlYQEst7tLdLK4e5mrLFMxJRvwOP1tCf0oEdSuhlbziHPEohBqG1sN/yoqAEBlO
 clphcH5NhDSEwNzBUfHPkkj2s95eLY0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-N62V4X9ZMeSyOU5u5D3XJA-1; Mon,
 11 May 2026 03:24:48 -0400
X-MC-Unique: N62V4X9ZMeSyOU5u5D3XJA-1
X-Mimecast-MFC-AGG-ID: N62V4X9ZMeSyOU5u5D3XJA_1778484288
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BED2A1800283; Mon, 11 May 2026 07:24:47 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 971CB1800286; Mon, 11 May 2026 07:24:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 2/2] tpm_emulator: Limit number of bytes read to
 negotiated buffer size
From: marcandre.lureau@redhat.com
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, armenon@redhat.com, 
 philmd@linaro.org
In-Reply-To: <20260430155150.2139517-3-stefanb@linux.ibm.com>
References: <20260430155150.2139517-1-stefanb@linux.ibm.com>
 <20260430155150.2139517-3-stefanb@linux.ibm.com>
Date: Mon, 11 May 2026 11:24:33 +0400
Message-Id: <177848427399.2424105.5941657596799568403.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=794;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=nrtkB2gFXqN1b4ICqnZ1aL55/l8HqvZklPR/upjtfyk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAYQ0tQ2MgexQTsPZonO9ZDLHBPu5DzOvxdzFL
 edPGlUcWZaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagGENAAKCRDa6OEJdZac
 5X/jD/4vRX+yNUBH9a3Pe0rn3a90v30biNecDMOAZGhGnNic5222W3ZeFsI3Zaqi8jhc1Lz/qVy
 0YwR4uWVGHMiCms7e534BOZYdtkqPzFywqjorZmGvwTnsmQq1iFfi5+zMHk0OBdI2Nb+xvEW+VR
 L0sbchzpAXrtK/AlqQFQjii+E41aKw/o7Pwr33f9IKazwyDzZn8RGqAaXZvgSH1cTDdkSzXA/KT
 3MhAwJXsqalG/7eF0ZX26gwhIgwd4HS0vlXEMZk5b0pdQnp7aon71p2/f4moUMBX5kEiSpHIql6
 ldOVzuEZl3uTlkw/vqHMcQdNhg9VIo0pg8ZNfvrPTlflxrszwtsx7XrAfwF+nzbdz2gQaJDGj4C
 Pp40YVspjbQQJbA8utTIpcDrnuOKS9ppM5kH6qGQhFULcPtfVoHKAyiH84RqeukIFozfVig/hHx
 12L9kBcOpFk73Im4bl90DnfFiowS/DDBK17NvFGmMyb20w3wXJ4WotkmuHsEAOLBsdHSj55fnB5
 vvOle3f+LvmQF69eiCys/yQvimAISSGyi30MeMJBj1kEH06KSsb78fme0NeUeEX6tOZkjLtG99V
 +XrzaIuPNIfCDZyknBIZPLKfN1GP9oMRmPsqqnxcZexR1d77Z+9K/0eqEonQtfKu3uyWAhdxvkj
 dbP9CupTU5UdhYA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Thu, 30 Apr 2026 15:51:50 +0000, Stefan Berger <stefanb@linux.ibm.com> wrote:
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index 653989ac0e3..050a1f4225c 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -195,9 +196,13 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_emu,
>          return -1;
>      }
>  
> +    /*
> +     * Size of response from swtpm must be <= out_len (= negotiated buffer size)
> +     */
> +    to_read = MIN(tpm_cmd_get_size(out), out_len) - sizeof(struct tpm_resp_hdr);

I would check tpm_cmd_get_size(out) <= out_len explicitly and return an
error (probaby then disconnect) rather than silently corrupting the stream.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


