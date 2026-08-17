Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFF7C5CFC1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvro1-0007rp-Gs; Mon, 17 Aug 2026 03:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.de>) id 1wvrnt-0007rF-UV
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 03:30:41 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.de>) id 1wvrnr-0007mN-Ng
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 03:30:41 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 9A00E240028
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 09:30:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
 s=1984.8680eb; t=1786951834;
 bh=BBW43TwT98PkM7kpo9E6kSU/ArTLDWT7KWd12/kto0Q=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
 Content-Transfer-Encoding:From;
 b=KWAZUwWOqJn0TvySBhQHCLPg+BbzBmcKzKax5EmaMRsCW8R/cd6ix6uwjQ8KlIOkg
 eqhypdrzjbmfKLCtw3F03Zxy8g+0pRCCwWbmgG7UiCztmrM01bm92Is2HhlmewgKiV
 LNq3vkihM/3yGdpT71G4bP7Fair7jYP+pEBbP0x0/OQpV9lpsrDNqjt0kCkMTt3+V3
 ducNJa3KR+i7tAvFN2CnfT3tCA7a8/6/Ufye+XDV+sfr/8nCkd3LDMYiPnh5Lf0jeJ
 ludXzxSmdFb6vJ8JLu6/EaHqbwHmT3fCkSV3deha98qZnFjFT6+e5V74Gp4udvOYgf
 Qsf2IvqHcJ4Rw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4hNkyJ2VdRz9rxF;
 Mon, 17 Aug 2026 09:30:32 +0200 (CEST)
Message-ID: <8105c239-3730-4131-8f17-20de1bd85599@posteo.de>
Date: Mon, 17 Aug 2026 07:30:33 +0000
MIME-Version: 1.0
Subject: Re: [PATCH v3 11/49] python, tests: switch usernet queries from HMP
 to QMP
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-11-e53fc35bc550@redhat.com>
Content-Language: en-US
From: Thomas Huth <th.huth@posteo.de>
In-Reply-To: <20260816-qemu-no-hmp-v3-11-e53fc35bc550@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.65; envelope-from=th.huth@posteo.de;
 helo=mout01.posteo.de
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 16/08/2026 21.12, Marc-André Lureau wrote:
> Replace human-monitor-command "info usernet" calls with the structured
> x-query-usernet QMP command in get_usernet_hostfwd_port() and the VM
> test runner boot path.
> 
> Since x-query-usernet returns a list of UsernetInfo entries, callers
> now iterate over the result and extract the port from each entry's
> "info" field. Also switch get_info_usernet_hostfwd_port() from
> split('\r\n') to splitlines(), since QMP strings use \n rather than
> the HMP monitor's \r\n line endings.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>   python/qemu/utils/__init__.py       |  5 +++--
>   tests/functional/qemu_test/utils.py |  8 ++++++--
>   tests/vm/basevm.py                  | 13 ++++++++-----
>   3 files changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/python/qemu/utils/__init__.py b/python/qemu/utils/__init__.py
> index be5daa836340..e32911d4c6df 100644
> --- a/python/qemu/utils/__init__.py
> +++ b/python/qemu/utils/__init__.py
> @@ -46,10 +46,11 @@ def get_info_usernet_hostfwd_port(info_usernet_output: str) -> Optional[int]:
>       """
>       Returns the port given to the hostfwd parameter via info usernet
>   
> -    :param info_usernet_output: output generated by hmp command "info usernet"
> +    :param info_usernet_output: output generated by "info usernet" or
> +        the "info" field from x-query-usernet
>       :return: the port number allocated by the hostfwd option
>       """
> -    for line in info_usernet_output.split('\r\n'):
> +    for line in info_usernet_output.splitlines():
>           regex = r'TCP.HOST_FORWARD.*127\.0\.0\.1\s+(\d+)\s+10\.'
>           match = re.search(regex, line)
>           if match is not None:
> diff --git a/tests/functional/qemu_test/utils.py b/tests/functional/qemu_test/utils.py
> index 826c267785bd..0992db49ab28 100644
> --- a/tests/functional/qemu_test/utils.py
> +++ b/tests/functional/qemu_test/utils.py
> @@ -14,8 +14,12 @@
>   
>   
>   def get_usernet_hostfwd_port(vm):
> -    res = vm.cmd('human-monitor-command', command_line='info usernet')
> -    return get_info_usernet_hostfwd_port(res)
> +    res = vm.cmd('x-query-usernet')
> +    for entry in res:
> +        port = get_info_usernet_hostfwd_port(entry['info'])
> +        if port is not None:
> +            return port
> +    return None
>   
>   def pow2ceil(x):
>       """
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 9e879e966a36..198b04e8c375 100644
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -312,12 +312,15 @@ def boot(self, img, extra_args=[]):
>           self._guest = guest
>           # Init console so we can start consuming the chars.
>           self.console_init()
> -        usernet_info = guest.cmd("human-monitor-command",
> -                                 command_line="info usernet")
> -        self.ssh_port = get_info_usernet_hostfwd_port(usernet_info)
> +        res = guest.cmd("x-query-usernet")
> +        for entry in res:
> +            port = get_info_usernet_hostfwd_port(entry['info'])
> +            if port is not None:
> +                self.ssh_port = port
> +                break
>           if not self.ssh_port:
> -            raise Exception("Cannot find ssh port from 'info usernet':\n%s" % \
> -                            usernet_info)
> +            raise Exception("Cannot find ssh port from"
> +                            " 'x-query-usernet': %s" % res)
>   
>       def console_init(self, timeout = None):
>           if timeout == None:
While you're at it, may I suggest to move the cmd('x-query-usernet') into 
the get_info_usernet_hostfwd_port() function in 
python/qemu/utils/__init__.py, too, so that the callers don't have to take 
care about this anymore? Also just return the port number from there, so 
that the callers don't have to take care about the parsing. WDYT?

  Thomas


