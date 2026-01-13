Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E072D29DE2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 08:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfa2k-0006CF-0H; Tue, 13 Jan 2026 03:46:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfa2Y-000689-LJ
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 03:46:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfa2W-0002lz-LC
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 03:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768293959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=l2m81l2wvop+Pc8AYybdKF7AtJbgYndI10eUMeb13aw=;
 b=bYgbX2Csuuwpl3M3F7FoOwYh+gIAn9GUTvloc3QdhJD0oO8EYGOIdSuNkNmlPqZW2cbTUF
 /BSvevwLeJYSP2mYxdCd7Tg0Br7eAd10Cmq1WDf1587/NrNBR1S+iyCubrybwTqIiqTIw1
 FQ6brg38TonUeLLyKCqRQ2rVKw/Md2o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-YXdnkaLaO4C9TDgmVs7UNA-1; Tue, 13 Jan 2026 03:45:58 -0500
X-MC-Unique: YXdnkaLaO4C9TDgmVs7UNA-1
X-Mimecast-MFC-AGG-ID: YXdnkaLaO4C9TDgmVs7UNA_1768293957
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b8749dd495dso13128466b.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 00:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768293957; x=1768898757; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=l2m81l2wvop+Pc8AYybdKF7AtJbgYndI10eUMeb13aw=;
 b=QwASyGkIiZ/CMcqNyvx1A5EkU23Bl6bcwId8Q4cZ5iCIPoK2SfX0DMlFFrytj0JJZr
 OJP22sGUBKddcO7IJ4fduHmHVxhOjSq8pOTDXSvjGUQx6v02a4+xBDAum/RNedlA+zOS
 AEkL1zi/Il+oGigU5Su9MzGmSaBs/GUqJ8tnAtGtW0EagyPgQhjpGgYjTY1Kee754hKZ
 SrcEZdJEyUYm08Q57Vs+p/KfxRLRPdhFloNnaLFVzVDQEQn0y8pW5O7wp6X2RCzu5Tc/
 hQCto0pgA7UwZMAiUw8cSFXimEw2arem9TC+ifdOXI0n2fdXuZoIFzOs1JwV28ynv+PX
 Dz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768293957; x=1768898757;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l2m81l2wvop+Pc8AYybdKF7AtJbgYndI10eUMeb13aw=;
 b=UzfilW986xAHpStWepF+bm/pk9Oy0Vuq4PfkCSVcqvru044pRgS8HcSdB1KT1eZUTA
 o98NpOM02O0tekdGaGxgDNVgbRzeSecrNVh/ICS2G+ir+8dBu/Ket7rkKJnAFNb936SC
 D7LK2tzNpEp6UXjlWJQnhIb+tDPfppYyvcZ3tw0Y4tmW7s9Bgbr7FNcYX7DJqfAJaB5W
 WPmnX5pEJyGZQypSNovD6qIoS4nLoDijYtxN0Zi8KDXWhXqevtSCKq4Vpt9ZZEHL3s36
 Bnt2KXFKBF6NmV9IqtHcZ1ud25hqFdkL2+3xRwCJ/t1JfT7rxvE+43G9LNl0dMdvzm6h
 /Dfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxmEJdOL9QBtIA++beoCl9SylLZE2bA+HRgOERCWsEo0e3o2Y3rU5COZ7TbCcHntBUmtnoESRrTRCD@nongnu.org
X-Gm-Message-State: AOJu0YzFheNOePjEXP2OzCUuALrSv6z05ne3jE2Q4nHQ815RpGgtkbqS
 34x2m4gTqahCWv2ffH8QEUkPmpdzzQleWZSzvVTY+f9h1KMnELK2m83X+acRdE6Bs0KZOKX8sfn
 UqaWcHNaFpxFELT6tLssyWKrId/VhKhH7WSNung/TqyYH23VaIgKf5Yzc
X-Gm-Gg: AY/fxX4U+M1XFwCHI1VhpmrZ1SO+uohTn+YWQmekiIHE+XsP6cRkb6BPc6mXvscgVXl
 UcTsyfwH7VzWrBzvKd0JMqsR2df5op3wQc/8zches6XxyYJFVnQgM05qFnqE7ViWVv/24iyU1hu
 7Mg1PXcwjjL/CxtsBg/Stc3wXwbMI5AH7Aw8bILVr4BeTIZnJyxmkjXUrgGNFkKHQOvvLuMkrns
 jgPB/iVDiI1yHJpwrBbApA6tqXhXLqDXu9eyEXZvdIWzLYDXCe+E34mpiyj/DvO2ThIOEt4o2Od
 laUIj9sCuoNUxkqUBNsaGts3Uz7E76IOB+LjNpwZxq23xCDte7P0cjk4dBnaETIJVNNFt+ATrU6
 BLevDeMI=
X-Received: by 2002:a17:907:f815:b0:b73:544d:ba2e with SMTP id
 a640c23a62f3a-b84451cecd4mr1897713566b.25.1768293957087; 
 Tue, 13 Jan 2026 00:45:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiMsb/AM6B8Afwr63kaXpDzRApLuNOeVdmSfRAAgHCJJmIYCqXf2MTTrNneEII4PYneYs9ng==
X-Received: by 2002:a17:907:f815:b0:b73:544d:ba2e with SMTP id
 a640c23a62f3a-b84451cecd4mr1897711566b.25.1768293956596; 
 Tue, 13 Jan 2026 00:45:56 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8706c2604bsm727574066b.16.2026.01.13.00.45.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 00:45:56 -0800 (PST)
Message-ID: <b5d72aff-2847-420c-9c1f-23fc23e1b75d@redhat.com>
Date: Tue, 13 Jan 2026 09:45:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/3] tests/functional/x86_64: Add vhost-user-bridge
 test
To: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@gmail.com>
References: <20260112230127.99125-1-yodel.eldar@yodel.dev>
 <20260112230127.99125-3-yodel.eldar@yodel.dev>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260112230127.99125-3-yodel.eldar@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 13/01/2026 00.01, Yodel Eldar wrote:
> Introduce a functional test of vhost-user-bridge and enter it into
> MAINTAINERS under the vhost section.
> 
> The test runs vhost-user-bridge as a subprocess, then launches a guest
> with four backends: a unix domain socket for vhost-user, a UDP socket, a
> user-mode net, and a hubport to hub the UDP and user backends; only the
> vhost-user backend is exposed, the rest are deviceless. This
> configuration mimics the testing setup described in the initial commit
> of vhost-user-bridge in 3595e2eb0a23.
> 
> A file containing a hardcoded UUID is created by the test in a scratch
> file and exposed to the guest via the tftp parameter of the user netdev.
> The guest requests the file by invoking tftp, and the test verifies its
> sha256 hashsum.
> 
> Similarly, a file containing another hardcoded UUID is created in the
> guest. A call to check_http_download() serves the file via http to the
> host and verifies integrity with its hashsum.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Suggested-by: Marc-André Lureau <marcandre.lureau@gmail.com>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
> ---
...
> +    def test_vhost_user_bridge(self):
> +        prompt = "~ # "
> +        host_uuid_filename = "vubr-test-uuid.txt"
> +        guest_uuid_path = "/tmp/uuid.txt"
> +        kernel_path = self.ASSET_KERNEL_INITRAMFS.fetch()
> +
> +        vubr_path = self.build_file("contrib", "vhost-user-bridge",
> +                                    "vhost-user-bridge")
> +        if is_readable_executable_file(vubr_path) is None:
> +            self.skipTest("Could not find a readable and executable "
> +                          "vhost-user-bridge")
> +
> +        vubr_log_path = self.log_file("vhost-user-bridge.log")
> +        self.log.info("For the vhost-user-bridge application log,"
> +                     f" see: {vubr_log_path}")
> +
> +        sock_dir = self.socket_dir()
> +        ud_socket_path = os.path.join(sock_dir.name, "vubr-test.sock")
> +
> +        tftpdir = self.scratch_file("tftp")
> +        shutil.rmtree(tftpdir, ignore_errors=True)
> +        os.mkdir(tftpdir)
> +        host_uuid_path = self.scratch_file("tftp", host_uuid_filename)
> +        with open(host_uuid_path, "w") as host_uuid_file:

FYI, I just got another test merged that checks the files with pylint now - 
you might need to add an encoding="ascii" or encoding="utf-8" to that open() 
call now to avoid that pylint complains.

> +            host_uuid_file.write(self.HOST_UUID)
> +
> +        with Ports() as ports:
> +            lport, rport, hostfwd_port = ports.find_free_ports(3)
> +
> +            self.configure_vm(ud_socket_path, lport, rport, hostfwd_port,
> +                              tftpdir)
> +
> +            vubr_args = self.assemble_vubr_args(vubr_path, ud_socket_path,
> +                                                lport, rport)
> +
> +            with open(vubr_log_path, "w+") as vubr_log, \

dito.

> +                 subprocess.Popen(vubr_args, stdin=subprocess.DEVNULL,
> +                                  stdout=vubr_log,
> +                                  stderr=subprocess.STDOUT) as vubr_proc:
> +                self.launch_kernel(kernel_path, wait_for=prompt)
> +
> +                exec_command_and_wait_for_pattern(self,
> +                    f"tftp -g -r {host_uuid_filename} 10.0.2.2 ; "
> +                    f"sha256sum {host_uuid_filename}", self.HOST_UUID_HSUM)
> +                wait_for_console_pattern(self, prompt)
> +
> +                exec_command_and_wait_for_pattern(self,
> +                    f"echo -n '{self.GUEST_UUID}' > {guest_uuid_path}", prompt)
> +                self.check_http_download(guest_uuid_path, self.GUEST_UUID_HSUM)
> +                wait_for_console_pattern(self, prompt)
> +
> +                self.vm.shutdown()
> +                vubr_proc.terminate()
> +                vubr_proc.wait()
> +
> +if __name__ == '__main__':
> +    LinuxKernelTest.main()

With the encoding=... added:
Reviewed-by: Thomas Huth <thuth@redhat.com>


