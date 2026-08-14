Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C82C5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wum0C-0007J9-Es; Fri, 14 Aug 2026 03:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wum0B-0007Ix-55
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 03:06:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wum09-0005eX-4b
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 03:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786691206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BWxtmaRNH75ssF396hYu+9fWzwDV1tzhVpKkZpbTj3w=;
 b=C/JY6yJ00TLwtPtqm0kfRs3wgGc/2YYWcobmAv2+1qGD83Le7JHTKBZPrcl9kjEz4xSSd6
 6UKfVR7fGojWlgU71HDzEGXYQzxCX6i5vhAVuomrbrVhponXalotB1PAhI0uj46j9fJFG4
 xgu0SvWGzHqK7t/6B1HLAe9f6H6y7+s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-6OL3XROwNhyW0IOHqoCfqA-1; Fri, 14 Aug 2026 03:06:45 -0400
X-MC-Unique: 6OL3XROwNhyW0IOHqoCfqA-1
X-Mimecast-MFC-AGG-ID: 6OL3XROwNhyW0IOHqoCfqA_1786691204
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-492488f8583so5323915e9.2
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 00:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786691204; x=1787296004; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BWxtmaRNH75ssF396hYu+9fWzwDV1tzhVpKkZpbTj3w=;
 b=oTvGhEMbdxTXcR6Y7R1qaLKm+RPpE9VhhsB4CK+vpaqYlLwq+7b9rltb5uttW5GbXQ
 QBcjXE/uG7I1HwwWLeobORVY2NvLKofKByBrkolK8WczDI4KjMppH4ej4wrl3+OawIaJ
 cueIWKF/1msBp+yjcvMiF2AHFvdTbnnFjLMNQk8J4jy9ToT9hZbpPyzlogoRS2XjFoi6
 n+iURznbpeYyID59ZDDl2fwGQYNqpvfNRUGlVNY1+8d73SgNqCdmhbV3iKMvSz5xRByr
 Jqlzwt1J4y8HtFtwJzv/o0pe/4DgZWhOOkxe9EHMnXmq1K50D+a/dnJMRQoc3Lhozlhx
 ZtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786691204; x=1787296004;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BWxtmaRNH75ssF396hYu+9fWzwDV1tzhVpKkZpbTj3w=;
 b=i9UhXuA6wPQ8POT6XeS7yCrKIyCQ4OR85AoqMgsTWYwXw62pTNnGUYmboa+hbFps+f
 nWYI62zwRRB935zgWIfaDR6ZdSMsnNyunAHm8XSRdjirN4df8YwL1sBdLr4Av6vk37g7
 S1ckm3kG/fKDv4TN5KfFc1S0MUnDM94mtdDNMeuwqIEXhs3Xe++T1c4UUVBD8Ox8G3l9
 fbxaByQkDv/7+oeAyS/eHOJmsgSJQ++pNHNQU++2HyTsncLhk0+/z3zLYG7JctTqwpbN
 vQYrcADKKYhB7hOq7Qf8Ry6kUplc+ZHNQGaaib9oPEvCF+FD3jgFTW8w4MBE+0jQIqMP
 6Z5Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJGgpo4fB3dSN6wve/dKmxyNTAJhLN7jj4aQ2gXoasNHPnIqnTzla5HBU/upbBQqOFLn1s7ckNyzsw@nongnu.org
X-Gm-Message-State: AOJu0YyENf6CvDW3xonMbdNsRz4y8zhXKGddRYsoc+EM8tYJAQu6IJCs
 ZeDL6p23GEoidutoW7MvaBkICJ6XJ/zU9j3twADymYO6B48RVrwvDHB+fh+ay2DhXMZjL0ZDI5F
 50tTBbjeTRzVS16IGw+lgmCFDvuarHVR/cRCYc8iacnbGDt+ZkBpGr7Mr
X-Gm-Gg: AR+sD10HkHQp6yJOBE+9xSyI0HRbJ69HlHoyWOTFrzqXwmvmx7pVKlKlKB4AaMy+6QW
 kKu6gSHwamZ4sAQ8NFBgzQ9aXR9vFLNzFYGtwL4b8jKBHwn1EMOecWJwo86qvF9gVR3lnBg2k5H
 LYUfMarf7Ov3xrNzdT9X7E22x3OucPpoMx8/pnx7TYLxU+7+P8thpmD5xWxm7cxKzqR4s13ownF
 nk9ncr8vrqMJKI381KAECvGU7/O2M0oupl1l8/761oiKAty0qPigViCmABOC6aLvy1xicqCNoEK
 UZLiBRNRRwL/GDSq1rNXdfJX/3+v2YOyesu6lmJAcP6N0pPNZWkvpxMo5mqUi5AlWC48tmFl
X-Received: by 2002:a05:600c:1911:b0:495:6274:56c2 with SMTP id
 5b1f17b1804b1-49987941a96mr38997785e9.2.1786691203791; 
 Fri, 14 Aug 2026 00:06:43 -0700 (PDT)
X-Received: by 2002:a05:600c:1911:b0:495:6274:56c2 with SMTP id
 5b1f17b1804b1-49987941a96mr38997085e9.2.1786691203410; 
 Fri, 14 Aug 2026 00:06:43 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.27]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b1d33asm30187695e9.10.2026.08.14.00.06.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2026 00:06:41 -0700 (PDT)
Message-ID: <b9479124-570a-4a81-8200-a76e3157d26f@redhat.com>
Date: Fri, 14 Aug 2026 09:06:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] python/qemu/machine: add possibility to postpone qmp
 connect
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 jasowang@redhat.com, mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, qemu-devel@nongnu.org,
 berrange@redhat.com, pbonzini@redhat.com, yc-core@yandex-team.ru,
 mark.caveayland@nutanix.com, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20260729093146.1893719-1-vsementsov@yandex-team.ru>
 <20260729093146.1893719-2-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260729093146.1893719-2-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On 29/07/2026 11.31, Vladimir Sementsov-Ogievskiy wrote:
> This is need to test cpr-transfer migration, as on started
> target QMP is not available until we call "migrate" on
> source.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   python/qemu/machine/machine.py | 53 ++++++++++++++++++----------------
>   1 file changed, 28 insertions(+), 25 deletions(-)
> 
> diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
> index bfb59d4c0bf..00154b8591f 100644
> --- a/python/qemu/machine/machine.py
> +++ b/python/qemu/machine/machine.py
> @@ -449,17 +449,17 @@ def _post_shutdown(self) -> None:
>           self._user_killed = False
>           self._launched = False
>   
> -    def launch(self) -> None:
> +    def launch(self, do_start_process=True, do_qmp_connect=True) -> None:

Could you drop the "do_" prefix from the parameter names? ... that does not 
provide any additional value here, I think.

>           """
>           Launch the VM and make sure we cleanup and expose the
>           command line/output in case of exception
>           """
>   
> -        if self._launched:
> +        if self._launched and do_start_process:
>               raise QEMUMachineError('VM already launched')
>   
>           try:
> -            self._launch()
> +            self._launch(do_start_process, do_qmp_connect)
>           except BaseException as exc:
>               # We may have launched the process but it may
>               # have exited before we could connect via QMP.
> @@ -482,31 +482,34 @@ def launch(self) -> None:
>               # that exception. However, we still want to clean up.
>               raise
>   
> -    def _launch(self) -> None:
> +    def _launch(self, do_start_process=True, do_qmp_connect=True) -> None:
>           """
>           Launch the VM and establish a QMP connection
>           """
> -        self._pre_launch()
> -        LOG.debug('VM launch command: %r', ' '.join(self._qemu_full_args))
> -        # Log a simplified, developer-runnable command:
> -        # Exclude harness-managed infrastructure args (harness_args)
> -        # and wrapper.
> -        debug_cmd = [self._binary]
> -        debug_cmd.extend(self._console_args(interactive=True))
> -        debug_cmd.extend(self._base_args)
> -        debug_cmd.extend(self._args)
> -        LOG.debug('Developer-runnable command: %r', ' '.join(debug_cmd))
> -
> -        # Cleaning up of this subprocess is guaranteed by _do_shutdown.
> -        # pylint: disable=consider-using-with
> -        self._popen = subprocess.Popen(self._qemu_full_args,
> -                                       stdin=subprocess.DEVNULL,
> -                                       stdout=self._qemu_log_file,
> -                                       stderr=subprocess.STDOUT,
> -                                       shell=False,
> -                                       close_fds=False)
> -        self._launched = True
> -        self._post_launch()
> +        if do_start_process:
> +            self._pre_launch()
> +            LOG.debug('VM launch command: %r', ' '.join(self._qemu_full_args))
> +            # Log a simplified, developer-runnable command:
> +            # Exclude harness-managed infrastructure args (harness_args)
> +            # and wrapper.
> +            debug_cmd = [self._binary]
> +            debug_cmd.extend(self._console_args(interactive=True))
> +            debug_cmd.extend(self._base_args)
> +            debug_cmd.extend(self._args)
> +            LOG.debug('Developer-runnable command: %r', ' '.join(debug_cmd))
> +
> +            # Cleaning up of this subprocess is guaranteed by _do_shutdown.
> +            # pylint: disable=consider-using-with
> +            self._popen = subprocess.Popen(self._qemu_full_args,
> +                                           stdin=subprocess.DEVNULL,
> +                                           stdout=self._qemu_log_file,
> +                                           stderr=subprocess.STDOUT,
> +                                           shell=False,
> +                                           close_fds=False)
> +            self._launched = True
> +
> +        if do_qmp_connect:
> +            self._post_launch()
Honestly, I think this is quite confusing that callers now have to run 
"launch()" twice if they want to have a staged initialization.

Could you maybe drop the do_start_process parameter, just keep the 
qmp_connect parameter here. Then wrap the QMP connection stuff in a new 
separate function. So callers could do:

    vm.launch(qmp_connect=False)
    ... do other stuff ...
    vm.qmp_connect()
    # instead of vm.launch(do_start_process=False, do_qmp_connect=True)

WDYT?

  Thomas


